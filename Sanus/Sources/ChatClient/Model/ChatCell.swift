//
//  ChatCell.swift
//  Sanus
//
//  Created by luis on 19/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var txtNameUser: UILabel!
    @IBOutlet weak var avatar: UIImageView!
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
