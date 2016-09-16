//
//  Item.swift
//  Biblioteka
//
//  Created by Ernest Chechelski on 31.05.2016.
//  Copyright © 2016 Ernest Chechelski. All rights reserved.
//

import CoreData

class Item: NSManagedObject {
    @NSManaged var name:String!
    @NSManaged var type:String!
    @NSManaged var itemDescription:String!
    @NSManaged var image:NSData!
}
