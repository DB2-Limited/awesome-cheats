//
//  APIRouterProtocol.swift
//  IPAChatTest
//
//  Created by Yevhenii Lytvinenko on 4/4/18.
//  Copyright © 2018 Yevhenii Lytvinenko. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRouter: URLRequestConvertible {
    var path: String { get }
    var baseUrl: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}

extension APIRouter {
    
    func asURLRequest() throws -> URLRequest {
        let urlString = baseUrl + path
        let url = try urlString.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
}

extension Encodable {
  
    func asParameters() -> Parameters? {
        guard let data = try? JSONEncoder().encode(self),
              let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Parameters else {
                return nil
        }
        return json
    }
}


