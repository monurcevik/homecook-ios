import Alamofire

protocol Requestable {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
}
