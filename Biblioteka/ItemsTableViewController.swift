//
//  ItemsTableViewController.swift
//  Biblioteka
//
//  Created by Ernest Chechelski on 31.05.2016.
//  Copyright © 2016 Ernest Chechelski. All rights reserved.
//



import UIKit
import CoreData

class ItemsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var fetchResultController:NSFetchedResultsController!
    var items:[Item] = []
    var item:Item!
    
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    
    @IBAction func confirmItemAndUnwindToHomeScreen(segue:UIStoryboardSegue) {
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tableView.reloadData()
    
        
        
        
        var fetchRequest = NSFetchRequest(entityName: "Item")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext
        
        
        
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                               managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
        
        
        do
        {
            try fetchResultController.performFetch()
        
        }
        catch
        {
            
        }
        items = fetchResultController.fetchedObjects as! [Item]
        
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title:
            "Delete",handler: {
                (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                // Delete the row from the data source
                let managedObjectContext = (UIApplication.sharedApplication().delegate as!
                    AppDelegate).managedObjectContext
                let restaurantToDelete = self.fetchResultController.objectAtIndexPath(indexPath) as!
                Item
                
                managedObjectContext.deleteObject(restaurantToDelete)})
        
        
        
        
        print("Items count \(items.count)")
        
        
        
        
        
    
        
    }
    
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete)
        {
            let managedObjectContext = (UIApplication.sharedApplication().delegate as!
                AppDelegate).managedObjectContext
            
            managedObjectContext.deleteObject(items[indexPath.row])
            //items.removeAtIndex(indexPath.row)
        
        }
    }
        
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        _ = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title:
            "Delete",handler: {
                (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
                // Delete the row from the data source
                print("Delete handler")

                
                
        })

       
        navigationController?.hidesBarsOnSwipe = true
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Item"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ItemTableViewCell
        
        // Configure the cell...
        let item = items[indexPath.row]
        cell.itemName.text = item.name
        cell.itemImage.image = UIImage(data: item.image)
        cell.itemType.text = item.type
        
        // Circular image
        cell.itemImage.layer.cornerRadius = cell.itemImage.frame.size.width / 2
        cell.itemImage.clipsToBounds = true
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.tableView.reloadData()
        
        if segue.identifier == "showItem" {
            print("showItem")
           
            

            
                let destinationController = segue.destinationViewController as! ItemDetailsTableViewController
                print("DestinationController")
                destinationController.item = self.item
            
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        print(indexPath.row)
         self.item = items[indexPath.row]
        performSegueWithIdentifier("showItem", sender: nil)
       
        
    }
    

    
    
  
    
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject,
                    atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType,
                                newIndexPath: NSIndexPath?) {
        
        print("Change change change XD")
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            let managedObjectContext = (UIApplication.sharedApplication().delegate as!
                AppDelegate).managedObjectContext
            do
            {
                try managedObjectContext.save()
            }
            catch
            {
                
                
            }
            
           
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        default:
            tableView.reloadData()
        }
        items = controller.fetchedObjects as! [Item]
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
}
