//
//  ViewController.swift
//  LoginCustomDemo
//
//  Created by IMCS2 on 11/24/22.
//  Copyright © 2022 Chetan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore

class ViewController: UIViewController {
    @IBOutlet weak var userNumberTxtFld: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var verfication_ID: String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userPassword.isUserInteractionEnabled = false
    }
    
    func displayAlert(message: String) {
        
        let alert = UIAlertController(title: "Alert", message: "\(message)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        
        if (userNumberTxtFld.text == "" ) {
            displayAlert(message: "Enter Phone number")
        } else if ((userNumberTxtFld.text?.validPhoneNumber) == false) {
            displayAlert(message: "Wrong Phone number")
        }
        else {
            //Verify the phone number
            PhoneAuthProvider.provider()
                .verifyPhoneNumber(userNumberTxtFld.text ?? "" , uiDelegate: nil) { verificationID, error in
                    self.verfication_ID = verificationID
                    if (self.userPassword.text == nil) {
                        self.displayAlert(message: "Password input is empty")
                        self.userPassword.isUserInteractionEnabled = false

                    }else {
                        if let _ = error {
                            self.displayAlert(message: "phone number wrong and not registered")
                          return
                        } else {
                            //Checking the phone number
                            let credential : PhoneAuthCredential = PhoneAuthProvider.provider().credential(
                              withVerificationID: self.verfication_ID ?? "",
                              verificationCode: self.userPassword.text ?? ""
                            )
                            
                            if (verificationID != nil) {
                                self.userPassword.isUserInteractionEnabled = true
                                    if (self.userPassword.text) == "" {
                                        
                                    } else {
                                    Auth.auth().signIn(with: credential, completion: { completion, error in
                                        if error != nil {
                                            self.displayAlert(message: "Wrong OTP")
                                        } else {
                                            let storyBoard = self.storyboard?.instantiateViewController(identifier: "addViewController") as! AddTeamMemeberViewController
                                            self.present(storyBoard, animated: true, completion: nil)
                                        }
                                    })
                                    
                                }
                                
                            } else {
                                self.userPassword.isUserInteractionEnabled = false
                            }
                            }
                    }
            }
        }
    }
}



extension String {
    public var validPhoneNumber: Bool {
        let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count)).first?.phoneNumber {
            return match == self
        } else {
            return false
        }
    }
}


