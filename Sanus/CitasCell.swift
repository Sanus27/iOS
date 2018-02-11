//
//  CitasCell.swift
//  Sanus
//
//  Created by Luis on 11/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class CitasCell: UITableViewCell {

    
    @IBOutlet weak var avatarCitas: UIImageView!
    @IBOutlet weak var doctorCitas: UILabel!
    @IBOutlet weak var hospitalCitas: UILabel!
    @IBOutlet weak var fechaCitas: UILabel!
    @IBOutlet weak var horaCitas: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
