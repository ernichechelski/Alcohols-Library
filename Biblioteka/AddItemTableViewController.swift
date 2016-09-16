//
//  AddItemTableViewController.swift
//  Biblioteka
//
//  Created by Ernest Chechelski on 31.05.2016.
//  Copyright © 2016 Ernest Chechelski. All rights reserved.
//

import UIKit
import CoreData
class AddItemTableViewController: UITableViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

//    @IBOutlet var typeTextField: UITextField!
    
    @IBOutlet weak var imageView:UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var nameTextField: UITextField!
    
    
    
    let itemTypes:[String] = ["Absynt",
    "Anyżówka",
    "Arak",
    "Archi",
    "Armagnac",
    "Bimber",
    "Burbon",
    "Calvados",
    "Gin",
    "Genever",
    "Grappa",
    "Koniak",
    "Rakija",
    "Brandy",
    "Ajerkoniak",
    "Alasz",
    "Amaretto",
    "Echt stonsdorfer",
    "Goldwasser",
    "Malibu",
    "Sambuca",
    "Piołunówka",
    "Orzechówka",
    "Cytrynówka",
    "Malinówka",
    "Nalewka z wiśni",
    "Dereniówka",
    "Księżycówka",
    "Smorodinówka",
    "Ratafia",
    "Rum",
    "Rumtopf",
    "Śliwowica",
    "Tequila",
    "Whisky",
    "Winiak",
    "Wódka",
    "Siwucha",
    "Schnapps",
    "Pálinka",
    "Wiśniówka",
    "Żubrówka"]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet var typePickerView: UIPickerView!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func saveItem(sender: UIBarButtonItem) {
       
        
        print("saveItem")
        let managedObjectContext = (UIApplication.sharedApplication().delegate as!
            AppDelegate).managedObjectContext
        
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item",inManagedObjectContext: managedObjectContext) as! Item;
        item.name = self.nameTextField.text
        item.itemDescription = self.descriptionTextView.text
        item.image = UIImagePNGRepresentation(self.imageView.image!)
       // item.type = self.typeTextField.text
       // if(self.typeTextField.text!.isEmpty)
        //{
       //   item.type = "Nie podano"
        //}
        item.type = itemTypes[typePickerView.selectedRowInComponent(0)]
        if(!self.nameTextField.text!.isEmpty)
        {
            do
            {
                try managedObjectContext.save()
                performSegueWithIdentifier("unwind", sender: self)
                
            }
            catch
            {
                print("oops")
            }
            
        }
        else
        {
            let alert = UIAlertController(title: "Nie wpisano nazwy elementu", message: "Nazwa jest wymagana", preferredStyle: UIAlertControllerStyle.Alert)
            //alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    print("default")
                    
                case .Cancel:
                    print("cancel")
                    
                case .Destructive:
                    print("destructive")
                }
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        
        
        
        //restaurant.image = UIImagePNGRepresentation(imageView.image)
       // self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:
        NSIndexPath) {
        if indexPath.section == 0 {
             if indexPath.row == 0 {
                
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //imageView.clipsToBounds = true
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return itemTypes.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return itemTypes[row]
    }
    
    
}
