//
//  addModel.swift
//  LoginCustomDemo
//
//  Created by IMCS2 on 11/25/22.
//  Copyright © 2022 Chetan. All rights reserved.
//

import Foundation
import UIKit

class addModel {
    var name: String?
    var email: String?
    var phoneNumber: String?
    
    init(name: String, email: String, phoneNumber: String) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
    }
}

