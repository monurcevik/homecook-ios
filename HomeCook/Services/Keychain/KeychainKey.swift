enum KeychainKey {
    case RefreshToken, AuthToken
    
    var name: String {
        switch self {
        case .RefreshToken:
            return "refresh_token"
        case .AuthToken:
            return "auth_token"
        }
    }
}
