//
//  ItemCell.swift
//  LootLogger
//
//  Created by Michael Worden on 1/14/22.
//

import UIKit

class ItemCell: UITableViewCell {

    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!

    
    override func layoutSubviews() {
        super.layoutSubviews()

        //update your constraints
        //NOTE: there's no need to call layoutIfNeeded
    }

}


