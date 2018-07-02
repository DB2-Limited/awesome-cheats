//
//  ViewController.swift
//  APIExample
//
//  Created by Yevhenii Lytvinenko on 6/29/18.
//  Copyright © 2018 Yevhenii Lytvinenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model: UserRegistrationDTO?

    func register() {
        APIProvider.provideObject(APIRouter.signUp(model: model)) { (_ successDTO: SuccessResponseDTO?, error) in
            if successDTO?.success == true {
                //TODO: Handle success
                return
            }
            if let error = error {
                //TODO: Handle error
            }
        }
    }
}

