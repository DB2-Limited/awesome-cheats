//
//  ChatAPIProvider.swift
//  IPAChatTest
//
//  Created by Yevhenii Lytvinenko on 4/5/18.
//  Copyright © 2018 Yevhenii Lytvinenko. All rights reserved.
//

import Foundation
import Alamofire

enum CotentType: String {
    case applicationJson = "application/json"
}

class APIProvider {

    //MARK: Initialization

    private init() {}

    //MARK: Public methods

    static func provideObject<T: Decodable>(_ router: APIRouter, completion: @escaping (T?, ErrorDTO?) -> Void) {
        do {
            let request = try router.asURLRequest()
            execute(request: request, completion: completion)
        } catch {
            print("request creating error : \(error.localizedDescription)")
        }

    }

    static func provideList<T: Decodable>(_ router: APIRouter, completion: @escaping ([T]?, ErrorDTO?) -> Void) {
        do {
            let request = try router.asURLRequest()
            execute(request: request, completion: completion)
        } catch {
             print("request creating error : \(error.localizedDescription)")
        }
    }

    //MARK: Private methods

    static private func execute<T: Decodable, E: Decodable>(request: URLRequestConvertible, completion: @escaping(_ result: [T]?, _ error: E?) -> Void) {

        Alamofire.request(request)
            .validate(contentType: [CotentType.applicationJson.rawValue])
            .responseString(completionHandler: { (response) in
                switch response.result {
                case .success(_):
                    guard let str = response.result.value else {
                        break
                    }
                    let models = str.parseJsonAsList(of: T.self)
                    let error = str.parseJson(as: E.self)
                    completion(models, error)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
    
    static private func execute<T: Decodable, E: Decodable>(request: URLRequestConvertible, completion: @escaping(_ result: T?, _ error: E?) -> Void) {
        
        Alamofire.request(request)
            .validate(contentType: [CotentType.applicationJson.rawValue])
            .responseString(completionHandler: { (response) in
                switch response.result{
                case .success(_):
                    guard let str = response.result.value else {
                        break
                    }
                    let model = str.parseJson(as: T.self)
                    let error = str.parseJson(as: E.self)
                    completion(model, error)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
    }
}


extension String {
    func parseJsonAsList<T: Decodable>(of type: T.Type) -> [T]? {
        
        guard let data = self.data(using: .utf8),
            let json = try? JSONDecoder().decode([T].self, from: data) else {
                
                return nil
        }
        return json
    }
    
    func parseJson<T: Decodable>(as type: T.Type) -> T! {
        guard let data = self.data(using: .utf8),
              let json = try? JSONDecoder().decode(T.self, from: data) else {
                
                return nil
        }
        return json
    }
}
