//
//  AddTableViewCell.swift
//  LoginCustomDemo
//
//  Created by IMCS2 on 11/25/22.
//  Copyright © 2022 Chetan. All rights reserved.
//

import UIKit

class AddTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    var addMembersModel: addModel?{
        didSet{
            nameLabel.text = addMembersModel?.name
            emailLabel.text = addMembersModel?.email
            phoneNumberLabel.text = addMembersModel?.phoneNumber
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
