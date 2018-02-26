//
//  ComentariosDrCell.swift
//  Sanus
//
//  Created by Luis on 15/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit

class ComentariosDrCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var usuario: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var comentario: UILabel!
    
    @IBOutlet weak var starUno: UIButton!
    @IBOutlet weak var starDos: UIButton!
    @IBOutlet weak var starTres: UIButton!
    @IBOutlet weak var starCuatro: UIButton!
    @IBOutlet weak var starCinco: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
