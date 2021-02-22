import Alamofire

enum Environment {
    case Development
    case Production
}

class APIService {
    static let environment: Environment = .Development
    static var shared: APIService {
        return APIService(session: Session())
    }
    
    private let session: Session

    private init(session: Session) {
        self.session = session
    }
    
    func call<T>(to endpoint: Requestable, completion: @escaping (_ response: T?, _ error: ErrorObject?) -> Void) where T: Codable {
        call(to: endpoint, params: String?.none, completion: completion)
    }
    
    // swiftlint:disable cyclomatic_complexity
    func call<T, U>(to endpoint: Requestable, params: U?, completion: @escaping (_ response: T?, _ error: ErrorObject?) -> Void) where T: Codable, U: Codable {
        var url = URLRequest(url: endpoint.url)
        if let params = params {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            do {
                let jsonData = try encoder.encode(params)
                url.httpBody = jsonData
            } catch let error as EncodingError {
                DispatchQueue.main.async {
                    completion(nil, ErrorObject(error: error.localizedDescription))
                }
                return
            } catch {}
        }
        url.httpMethod = endpoint.httpMethod.rawValue
        url.headers = endpoint.headers
        session.request(url).validate().responseJSON { response in
            if response.response?.statusCode == 401 {
                // request is unauthorized per JWT
                // try acquiring new JWT token using user refresh token
                guard let userRefreshToken = KeychainManager.shared.get("refresh_token") else {
                    DispatchQueue.main.async {
                        completion(nil, ErrorObject(error: "Your session has expired. Please sign in again.".localized))
                        Authentication.signOut()
                    }
                    return
                }
                self.call(to: Endpoint.getReauth(userRefreshToken)) { (response: Userv2?, error: ErrorObject?) in
                    if let error = error {
                        DispatchQueue.main.async {
                            completion(nil, error)
                            Authentication.signOut()
                        }
                        return
                    }
                    guard let user = response, let token = user.token else {
                        DispatchQueue.main.async {
                            completion(nil, ErrorObject(error: "Your session has expired. Please sign in again.".localized))
                            Authentication.signOut()
                        }
                        return
                    }
                    // acquired new JWT token. save it and recall the initiating request
                    KeychainManager.shared.set(token, key: "token")
                    self.call(to: endpoint, params: params, completion: completion)
                }
                return
            }
            let decoder = self.getDecoder()
            
            if let jsonData = response.data {
                do {
                    let error = try decoder.decode(ErrorObject.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                } catch {}
                
                do {
                    let result = try decoder.decode(T.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(result, nil)
                    }
                } catch let error as DecodingError {
                    DispatchQueue.main.async {
                        completion(nil, ErrorObject(error: error.localizedDescription))
                    }
                } catch {}
            } else {
                DispatchQueue.main.async {
                    completion(nil, ErrorObject(error: "An error occured. Please try again.".localized))
                }
                return
            }
        }
    }
    
    private func getDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .base64
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            return Date()
        })
        
        return decoder
    }
    
    func upload(_ fileData: Data? = nil, asURL fileURL: URL? = nil, to route: StorageBucket, withExtension fileExtension: String, withType mimeType: String, completion: @escaping (_ response: UploadedFile?, _ error: ErrorObject?) -> Void) {
        let parameters = [
            "bucket": route.rawValue
        ]
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data"
        ]
        session.upload(multipartFormData: { multipartFormData in
            // withName is JSON key name of the uploaded file. fileName should have fileExtension in it's name.
            // for large videos, using URL decreases the memory usage.
            if let data = fileData {
                multipartFormData.append(data, withName: "file", fileName: Helper.randomString(length: 16) + fileExtension, mimeType: mimeType)
            }
            if let url = fileURL {
                multipartFormData.append(url, withName: "file", fileName: Helper.randomString(length: 16) + fileExtension, mimeType: mimeType)
            }
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
        }, to: Endpoint.uploadFile.url, usingThreshold: UInt64.init(), method: .post, headers: headers)
        .responseJSON { response in
            if response.response?.statusCode == 401 {
                // request is unauthorized per JWT
                // try acquiring new JWT token using user refresh token
                guard let userRefreshToken = KeychainManager.shared.get("refresh_token") else {
                    DispatchQueue.main.async {
                        completion(nil, ErrorObject(error: "Your session has expired. Please sign in again.".localized))
                        Authentication.signOut()
                    }
                    return
                }
                self.call(to: Endpoint.getReauth(userRefreshToken)) { (response: Userv2?, error: ErrorObject?) in
                    if let error = error {
                        DispatchQueue.main.async {
                            completion(nil, error)
                            Authentication.signOut()
                        }
                        return
                    }
                    guard let user = response, let token = user.token else {
                        DispatchQueue.main.async {
                            completion(nil, ErrorObject(error: "Your session has expired. Please sign in again.".localized))
                            Authentication.signOut()
                        }
                        return
                    }
                    // acquired new JWT token. save it and recall the initiating request
                    KeychainManager.shared.set(token, key: "token")
                    self.upload(fileData, to: route, withExtension: fileExtension, withType: mimeType, completion: completion)
                }
                return
            }
            
            let decoder = self.getDecoder()
            
            if let jsonData = response.data {
                if let error = try? decoder.decode(ErrorObject.self, from: jsonData) {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                } else {
                    do {
                        let result = try decoder.decode(UploadedFile.self, from: jsonData)
                        DispatchQueue.main.async {
                            completion(result, nil)
                        }
                    } catch let error as DecodingError {
                        DispatchQueue.main.async {
                            completion(nil, ErrorObject(error: error.localizedDescription))
                        }
                    } catch {}
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, ErrorObject(error: "An error occured. Please try again.".localized))
                }
            }
        }
    }
}
