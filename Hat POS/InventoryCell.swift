//
//  InventoryCell.swift
//  Hat POS
//
//  Created by Brendan on 3/16/21.
//

import UIKit

class InventoryCell: UITableViewCell{
    
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var productNameView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    
    @IBOutlet weak var productDescriptionView: UIView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    @IBOutlet weak var qtyView: UIView!
    @IBOutlet weak var qtyLabel: UILabel!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
