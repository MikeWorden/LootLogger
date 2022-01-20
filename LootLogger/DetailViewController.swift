//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Michael Worden on 1/18/22.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
  
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    
    var item: Item! {
        didSet {
            //navigationItem.title = item.name
           
        }
    }

    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        //valueField.text = "\(item.valueInDollars)"
        //dateLabel.text = "\(item.dateCreated)"
        valueField.text =
                numberFormatter.string(from: NSNumber(value:item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // "Save" changes to item
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        // Clear first responder
            view.endEditing(true)


        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "changeDate":
            // Figure out which row was just tapped
            /*if let row = tableView.indexPathForSelectedRow?.row {

                // Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController
                        = segue.destination as! DetailViewController
                detailViewController.item = item*/
                
                let dateViewController = segue.destination as! DateViewController
                dateViewController.item = item
                let backItem = UIBarButtonItem()
                backItem.title = "Update Date"
                navigationItem.backBarButtonItem = backItem
                
            
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }

    
    
    
    
}

    
