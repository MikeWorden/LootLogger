//
//  DetailViewController.swift
//  LootLogger
//
//  Created by Michael Worden on 1/18/22.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
	// MARK: -
	// MARK:  IBOutlets
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
	
	// MARK: -
	// MARK:  Variables
	var imageStore: ImageStore!
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

	// MARK: -
    // MARK: IBActions
	@IBAction func deletePhoto(_ sender: Any) {
		//remove the image from the imageView
		imageView.image = nil
		// And delete the image for the item
		imageStore.deleteImage(forKey: item.itemKey)
		
	}
	
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
	// MARK: -
	//MARK: Functions
	@IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {

		let alertController = UIAlertController(title: nil,
											message: nil,   preferredStyle: .actionSheet)


		alertController.modalPresentationStyle = .popover
		alertController.popoverPresentationController?.barButtonItem = sender
	
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
			// print("Present camera")
			let imagePicker = self.imagePicker(for: .camera)
			imagePicker.allowsEditing = true
			self.present(imagePicker, animated: true, completion: nil)
			
		}
		alertController.addAction(cameraAction)
	}

	

		let photoLibraryAction
			= UIAlertAction(title: "Photo Library", style: .default) { _ in
		//print("Present photo library")
				let imagePicker = self.imagePicker(for: .photoLibrary)
				self.present(imagePicker, animated: true, completion: nil)
			}
		alertController.addAction(photoLibraryAction)
	
	
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alertController.addAction(cancelAction)
		present(alertController, animated: true, completion: nil)


}




	



	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		nameField.text = item.name
		serialNumberField.text = item.serialNumber
		//valueField.text = "\(item.valueInDollars)"
		//dateLabel.text = "\(item.dateCreated)"
		valueField.text =
		numberFormatter.string(from: NSNumber(value:item.valueInDollars))
		dateLabel.text = dateFormatter.string(from: item.dateCreated)
		// Get the item key
		let key = item.itemKey
		
		// if there is an associated image, retrieve & display it
		let imageToDisplay = imageStore.image(forKey: key)
		imageView.image = imageToDisplay
		
		
		
	}
	func imagePicker(for sourceType: UIImagePickerController.SourceType)
	-> UIImagePickerController {
		let imagePicker = UIImagePickerController()
		
		imagePicker.sourceType = sourceType
		imagePicker.delegate = self
		imagePicker.allowsEditing = true
		
		
		return imagePicker
	}
	
	func imagePickerController(_ picker: UIImagePickerController,
							   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		
		
		
		guard  let image = info[.editedImage] as? UIImage else {
			return
		}
		
		
		// Store the image in the ImageStore for the item's key
		imageStore.setImage(image, forKey: item.itemKey)
		
		
		// Put that image on the screen in the image view
		imageView.image = image
		
		// Take image picker off the screen - you must call this dismiss method
		dismiss(animated: true, completion: nil)
		
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

    
