//
//  ELErrorDTO.swift
//  drone-i
//
//  Created by Yevhenii Lytvinenko on 6/21/18.
//  Copyright © 2018 Yevhenii Lytvinenko. All rights reserved.
//

import Foundation

struct ErrorDTO: Codable {
    let type: String
    let message: String
}
