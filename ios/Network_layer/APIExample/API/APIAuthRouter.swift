//
//  APIRouter.swift
//  FlirtAR
//
//  Created by user on 7/13/17.
//  Copyright © 2017 user. All rights reserved.
//

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
