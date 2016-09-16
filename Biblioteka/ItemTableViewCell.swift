//
//  ItemTableViewCell.swift
//  Biblioteka
//
//  Created by Ernest Chechelski on 31.05.2016.
//  Copyright © 2016 Ernest Chechelski. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemType: UILabel!
    
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
