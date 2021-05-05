//
//  TransactionCell.swift
//  Hat POS
//
//  Created by Brendan on 4/13/21.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    @IBOutlet weak var tIDView: UIView!
    @IBOutlet weak var tIDLabel: UILabel!
    
    @IBOutlet weak var eIDView: UIView!
    @IBOutlet weak var eIDLabel: UILabel!
    
    @IBOutlet weak var cIDView: UIView!
    @IBOutlet weak var cIDLabel: UILabel!
    
    @IBOutlet weak var pIDView: UIView!
    @IBOutlet weak var pIDLabel: UILabel!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var subTotalView: UIView!
    @IBOutlet weak var subTotalLabel: UILabel!
    
    @IBOutlet weak var taxView: UIView!
    @IBOutlet weak var taxLabel: UILabel!
    
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
