









//
//  EventViewController.swift
//  EventTrackerFinal
//
//  Created by Matthew Sargeant on 10/8/18.
//  Copyright © 2018 CVTC. All rights reserved.
//

import UIKit
import os.log

class EventViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  // MARK: - Properties

  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var dateTextField: UITextField!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var ratingControl: RatingControl!
  var event: Event?
  
  @IBOutlet weak var saveButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Handle the text field's userinpt through dlegate callbacks.
    nameTextField.delegate = self
    dateTextField.delegate = self
    
    // Set up views if editing an existing Event.
    if let event = event {
      navigationItem.title = event.name
      nameTextField.text   = event.name
      dateTextField.text   = event.date
      photoImageView.image = event.photo
      ratingControl.rating = event.rating
    }
    
    // Enable the Save button only if the text field has a valid Event name.
    updateSaveButtonState()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    updateSaveButtonState()
    navigationItem.title = textField.text
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // Disable the Save button while editing.
    saveButton.isEnabled = false
  }
  
  // MARK: UIImagePickerControllerDelegate
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    // Dismiss the picker if the user canceled.
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    // The info dictionary may contain multiple representations of the image. You want to use the original.
    guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
        fatalError("Expected a dictionary conaining an image, but was provided the folowing: \(info)")
    }
    
    photoImageView.image = selectedImage
    
    // Dismiss the picker
    dismiss(animated: true, completion: nil)
  }

  // MARK: Navigation
  
  @IBAction func cancel(_ sender: UIBarButtonItem) {
    // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
    let isPresentingInAddEventMode = presentingViewController is UINavigationController
    
    if isPresentingInAddEventMode {
      dismiss(animated: true, completion: nil)
    } else if let owningNavigationController = navigationController{
      owningNavigationController.popViewController(animated: true)
    } else {
      fatalError("The EventViewController is not inside a navigation controller.")
    }
    
    
    
  }
  
  // This method lets you configure a view controller before it's presented.
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    // Configure the destination view controller only when the save button is pressed.
    guard let button = sender as? UIBarButtonItem, button === saveButton else {
      os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
      return
    }
    
    let name = nameTextField.text ?? ""
    let date = dateTextField.text ?? ""
    let photo = photoImageView.image
    let rating = ratingControl.rating

    
    // Set the event to be passed to EventTableViewController after the unwind segue.
    event = Event(name: name, date: date, photo: photo, rating: rating)
  }
  
  
  // MARK: - Actions
  
  
  @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
    // Hide the keyboard.
    nameTextField.resignFirstResponder()
    
    // UIImagePickerController is a view controller that lets a user pick media from their photo library
    let imagePickerController = UIImagePickerController()
    
    // Only allow photos to be picked, not taken.
    imagePickerController.sourceType = .photoLibrary
    
    // Make sure ViewControlle ri snotified when the user picks an image.
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
    
    
  }
  
  // MARK: Private Methods
  private func updateSaveButtonState() {
    // Disable the Save button if the text field is empty.
    let text = nameTextField.text ?? ""
    saveButton.isEnabled = !text.isEmpty
  }
  
}

































