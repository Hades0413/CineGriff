//
//  ItemGeneroTableViewCell.swift
//  CineGriff
//
//  Created by mals on 6/12/24.
//

import UIKit

class ItemGeneroTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblCodigoGenero: UILabel!
    
    @IBOutlet weak var lblNombreGenero: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
