//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Jonathan Chong on 8/23/18.
//  Copyright © 2018 Jonathan Chong. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    var imageStore: ImageStore!
    
    /*Button Stuff ~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        //Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        //Figure out where that item is in the array
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
        //Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Remove \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                self.itemStore.removeItem(item)
                self.imageStore.deleteImage(forKey: item.itemKey)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
            
            //Remove the item from the store
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt: IndexPath) -> String? {
        return "Remove"
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("move")
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1
    }
    
    /* No more items stuff and Sections!! ~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    
    
    //-----------There's an issue right now with uneven index when I'm inserting a new row. Need to find cause. Is it sections or is it an issue with the indexPath because No more items! messed it up?
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Over $50"
        default:
            return "Others"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return itemStore.highValueItems.count
            
        default:
            return itemStore.otherItems.count + 1
        }
    }*/
    
    //prevent reordering silver challenge
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableViewCell, canEditRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row >= itemStore.allItems.count) {
            return false
        }
        else {
            return true
        }
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if (proposedDestinationIndexPath.row >= itemStore.allItems.count) {
            return sourceIndexPath
        }
        return proposedDestinationIndexPath
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let item = itemStore.allItems[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        return cell
        */
        
        
        if indexPath.row < itemStore.allItems.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
            let item = itemStore.allItems[indexPath.row]
            cell.nameLabel.text = item.name
            cell.serialNumberLabel.text = item.serialNumber
            cell.valueLabel.text = "$\(item.valueInDollars)"
            return cell
        }
        else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell_NMI")
            cell.textLabel?.text = "No more Items!"
            return cell
        }
        
        /*let items: [Item]
        switch indexPath.section {
        case 0:
            items = itemStore.highValueItems
        default:
            items = itemStore.otherItems
        }
        
        if indexPath.section == 1 && indexPath.row == items.count {
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = ""
        } else {
            let item = items[indexPath.row]
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "\(item.valueInDollars)"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        }
        cell.backgroundColor = UIColor.clear
        return cell*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showItem":
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //programmatically adds the left bar button item
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
}
