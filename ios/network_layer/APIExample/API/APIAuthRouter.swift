import Foundation
import Alamofire

enum APIAuthRouter: URLRequestConvertible {
    case signUp(model: UserRegistrationDTO)
}

//MARK: - APIRouterProtocol -

extension APIAuthRouter: APIRouter {
    var path: String {
        return "sign_up/"
    }
    
    var baseUrl: String {
        return "https://example.com/"
    }

    var method: HTTPMethod {
        switch self {
        case .signUp:
            return .post
        }
    }

    var parameters: Parameters? {
        switch self {
        case .signUp(let model):
            return model.asParameters()
        }
    }
}
