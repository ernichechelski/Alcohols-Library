//
//  ItemDetailsTableViewController.swift
//  Biblioteka
//
//  Created by Ernest Chechelski on 31.05.2016.
//  Copyright © 2016 Ernest Chechelski. All rights reserved.
//

import UIKit

class ItemDetailsTableViewController: UITableViewController {

    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var itemImage: UIImageView!
    var item:Item!
    
    override func viewDidLoad() {
        
         navigationController?.hidesBarsOnSwipe = false
            descriptionTextView.text = item.itemDescription
            typeLabel.text = item.type
            nameLabel.text = item.name
            itemImage.image = UIImage(data: item.image)
            descriptionTextView.sizeToFit()
       
    }
    
}
