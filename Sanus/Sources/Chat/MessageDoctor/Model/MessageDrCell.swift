//
//  MessageDrCell.swift
//  Sanus
//
//  Created by luis on 20/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class MessageDrCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var txtPaciente: UILabel!
    @IBOutlet weak var online: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
