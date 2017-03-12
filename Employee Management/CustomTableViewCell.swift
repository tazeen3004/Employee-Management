//
//  CustomTableViewCell.swift
//  Employee Management
//
//  Created by Tazeen on 11/03/17.
//  Copyright © 2017 Tazeen. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dojLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // to make the uiimageview circular
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
        // Configure the view for the selected state
    }

}
