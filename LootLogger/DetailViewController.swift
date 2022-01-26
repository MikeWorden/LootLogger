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
    
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: nil,
                                                    message: nil,   preferredStyle: .actionSheet)
        
        
        alertController.modalPresentationStyle = .popover
            alertController.popoverPresentationController?.barButtonItem = sender

        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                print("Present camera")
            }
            alertController.addAction(cameraAction)

        let photoLibraryAction
                    = UIAlertAction(title: "Photo Library", style: .default) { _ in
                print("Present photo library")
            }
            alertController.addAction(photoLibraryAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
        
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
   
   

    
    
    
    
}

    
