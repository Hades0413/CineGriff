//
//  ItemGoatTableViewCell.swift
//  CineGriff
//
//  Created by DAMII on 16/12/24.
//

import UIKit

class ItemGoatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgGoat: UIImageView!
    
    @IBOutlet weak var lblCodigo: UILabel!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblApellido: UILabel!
    
    @IBOutlet weak var lblCorreo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
