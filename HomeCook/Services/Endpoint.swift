import Alamofire

enum Endpoint {
    
}

extension Endpoint: Requestable {
    var baseURL: String {
        switch APIService.environment {
        case .Development:
            return ""
        case .Production:
            return ""
        }
    }
    
    var version: String {
        return "/v1.0"
    }
    
    var path: String {
        var tempPath: String!
        let token = KeychainService.shared.get("token") ?? "NOT_FOUND"
        /*switch self {
        case .getUserProfile(let id):
            tempPath = "/user/\(id)/profile?token=\(token)"
        }*/
        
        return tempPath
    }
    
    var httpMethod: HTTPMethod {
        /*switch self {
        case .logDeepLink:
            return .post
        }*/
        return .post
    }
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.path)!
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
}
