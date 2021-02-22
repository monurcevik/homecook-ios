import Alamofire

enum UserEndpoint {
    
}

extension UserEndpoint: Requestable {
    
    var path: String {
        var tempPath: String!
        let token = KeychainService.shared.get(.AuthToken) ?? "NOT_FOUND"
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
    
}
