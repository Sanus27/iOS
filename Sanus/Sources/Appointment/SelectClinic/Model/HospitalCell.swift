//
//  HospitalCell.swift
//  Sanus
//
//  Created by luis on 07/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class HospitalCell: UITableViewCell {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
