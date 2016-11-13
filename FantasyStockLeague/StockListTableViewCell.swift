//
//  StockListTableViewCell.swift
//  FantasyStockLeague
//
//  Created by neil robichaud on 2016-11-12.
//  Copyright © 2016 neil robichaud. All rights reserved.
//

import UIKit

class StockListTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var company: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
}
