//
//  MemeTableViewCell.swift
//  MoveKeyboard
//
//  Created by Edvin Lellhame on 6/9/16.
//  Copyright © 2016 Edvin Lellhame. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var topTextLabel: UILabel!
    @IBOutlet weak var topImageTextLabel: UILabel!
    @IBOutlet weak var bottomImageTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
