//
//  ELUserRegistration.swift
//  drone-i
//
//  Created by Yevhenii Lytvinenko on 3/5/18.
//  Copyright © 2018 Yevhenii Lytvinenko. All rights reserved.
//

import Foundation

struct UserRegistrationDTO: Codable {
    let email: String
    let password: String
    let confirmPassword: String
}
