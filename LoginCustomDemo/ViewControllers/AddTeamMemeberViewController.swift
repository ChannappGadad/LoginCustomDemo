//
//  AddTeamMemeberViewController.swift
//  LoginCustomDemo
//
//  Created by IMCS2 on 11/25/22.
//  Copyright © 2022 Chetan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddTeamMemeberViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var teamMemberButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    
    var ref = DatabaseReference.init()
    var addArray = [addModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.ref = Database.database().reference()
        
        getAllFirData()
    }

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    getAllFirData()

    return addArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddTableViewCell
    cell.addMembersModel = addArray[indexPath.row]
    return cell
}
        
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
}
    
    
    
    @IBAction func addTeamMember(_ sender: Any) {
//        tableView.reloadData().stop
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Add new member", message: "Enter name, email and phoneNumber", preferredStyle: .alert)
////
////        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter email"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter phone number"
        }
        
//        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let fields = alert.textFields, fields.count == 3 else {
                return
            }
            let nameField = fields[0]
            let emailField = fields[1]
            let phoneNumberField = fields[2]
            
            guard let name = nameField.text, !name.isEmpty,
                let email = emailField.text, !email.isEmpty,
                let phoneNumber = phoneNumberField.text, !phoneNumber.isEmpty else {
                    print("Ivalid entries")
                    return
            }
            self.saveFirData(name: name, emailId: email, phoneNumber: phoneNumber)
//            print("\(name)     \(email)    \(phoneNumber)")
        }))
        // 4. Present the alert.
        self.present(alert, animated: true)
        self.tableView.reloadData()
    }
    
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            self.dismiss(animated: true, completion: nil)
        } catch {
//            self.present(Service.createAlertController(title: "Error", message: signOutError.localizedDescription), animated: true, completion: nil)
        }
        
    }
    
    
    func saveFirData(name: String, emailId: String, phoneNumber: String) {
        let dic = ["Name": "\(name)", "Email": "\(emailId)", "PhoneNumber": "\(phoneNumber)"]
        self.ref.child("Add").childByAutoId().setValue(dic)
    }
    
    
        
    func getAllFirData() {
        
        self.ref.child("Add").queryOrderedByKey().observe(.value) {(snapshot) in
            self.addArray.removeAll()

            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
//                let arr = snapshot.map({$0.value as? [String: AnyObject]})
//                addArray = membersDic["Name"] as? String
                
                snapshot.forEach{snap in
                    if let membersDic = snap.value as? [String: AnyObject] {
                        let name = membersDic["Name"] as? String
                        let email = membersDic["Email"] as? String
                        let phoneNumber = membersDic["PhoneNumber"] as? String
                        
                        
                        self.addArray.append(addModel(name: name ?? "", email: email ?? "", phoneNumber: phoneNumber ?? ""))
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        //self.tableView.reloadData()
                        
                    }
                }
            }
            }
    }
}
