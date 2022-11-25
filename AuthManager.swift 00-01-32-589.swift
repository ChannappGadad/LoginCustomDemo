//
//  AuthManager.swift
//  LoginCustomDemo
//
//  Created by IMCS2 on 11/24/22.
//  Copyright © 2022 Chetan. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(userNumberTxtFld.text ?? "", uiDelegate: nil, completion: {verificationId, error in
                        if (error != nil) {
                            return
                            print("Error")
                        } else {
                            self.verfication_ID = verificationId
                        }
        })
    }
    
    public func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        
    }
}


