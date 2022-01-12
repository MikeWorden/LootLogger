//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by Michael Worden on 1/11/22.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton) {
        // Make a new index path for the 0th section, last row
        // Create a new item and add it to the store
        let newItem = itemStore.createItem()

            // Figure out where that item is in the array
            if let index = itemStore.allItems.firstIndex(of: newItem) {
                let indexPath = IndexPath(row: index, section: 0)

                // Insert this new row into the table
                tableView.insertRows(at: [indexPath], with: .automatic)
            }

       
    }

    

    @IBAction func toggleEditingMode(_ sender: UIButton) {
        // If you are currently in editing mode...
            if isEditing {
                // Change text of button to inform user of state
                sender.setTitle("Edit", for: .normal)

                // Turn off editing mode
                setEditing(false, animated: true)
            } else {
                // Change text of button to inform user of state
                sender.setTitle("Done", for: .normal)

                setEditing(true, animated: true)
            }

    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
            if editingStyle == .delete {
                let item = itemStore.allItems[indexPath.row]

                // Remove the item from the store
                itemStore.removeItem(item)

                // Also remove that row from the table view with an animation
                // Update
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }

    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        // Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }

    
    
    
    override func tableView(_ tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    
    override func tableView(_ tableView: UITableView,
            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create an instance of UITableViewCell with default appearance
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                for: indexPath)

        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the table view
        let item = itemStore.allItems[indexPath.row]

        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"

        return cell
    }

    
    
}
