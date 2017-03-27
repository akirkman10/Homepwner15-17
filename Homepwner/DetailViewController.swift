//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Alexis Kirkman on 3/20/17.
//  Copyright © 2017 Alexis Kirkman. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

   @IBOutlet var nameField: customTextField!
   @IBOutlet var serialNumberField: customTextField!
   @IBOutlet var valueField: customTextField!
   @IBOutlet var dateLabel: UILabel!
   @IBOutlet var imageView: UIImageView!
   @IBAction func takePicture(_ sender: UIBarButtonItem) {
      let imagePicker = UIImagePickerController()
      // If the device has a camera, take a picture; otherwise, 
      // just pick from photo library 
      if UIImagePickerController.isSourceTypeAvailable(.camera) {
         imagePicker.sourceType = .camera
      } else {
         imagePicker.sourceType = .photoLibrary
      }
      imagePicker.delegate = self
      // Place image picker on the screen 
      present(imagePicker, animated: true, completion: nil)
   
   }
   
   @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
      view.endEditing(true)
   }
   
   var item: Item!{
      didSet {
         navigationItem.title = item.name
      }
   }
   
   var imageStore: ImageStore!
   
   
   let numberFormatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      formatter.minimumFractionDigits = 2
      formatter.maximumFractionDigits = 2
      return formatter }()
   
   let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      formatter.timeStyle = .none
      return formatter }()

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      nameField.text = item.name
      serialNumberField.text = item.serialNumber
      valueField.text =
         numberFormatter.string( from: NSNumber(value: item.valueInDollars))
      dateLabel.text = dateFormatter.string(from: item.dateCreated)
      
      // Get the item key 
      let key = item.itemKey
      // If there is an associated image with the item 
      // display it on the image view 
      let imageToDisplay = imageStore.image(forKey: key)
      imageView.image = imageToDisplay
      
      
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      // Clear first responder 
      view.endEditing(true)
      

      // "Save" changes to item 
      item.name = nameField.text ?? ""
      item.serialNumber = serialNumberField.text
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
   
   func imagePickerController(_ picker: UIImagePickerController,
                              didFinishPickingMediaWithInfo info: [String: Any]) {
      // Get picked image from info dictionary 
      let image = info[ UIImagePickerControllerOriginalImage] as! UIImage
      
      // Store the image in the ImageStore for the item's key 
      imageStore.setImage(image, forKey: item.itemKey)
      

      // Put that image on the screen in the image view 
      imageView.image = image
      // Take image picker off the screen - 
      // you must call this dismiss method 
      dismiss(animated: true, completion: nil)
   }
   
   override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
      // If the triggered segue is the "showItem" segue
      switch segue.identifier {
      case "changeDate"?:
            let dateViewController = segue.destination as! DateViewController
            dateViewController.item = item
         
      default:
         preconditionFailure("Unexpected segue identifier.")
      }
   }

  
   
}


