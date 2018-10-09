









//
//  ViewController.swift
//  EventTrackerFinal
//
//  Created by Matthew Sargeant on 10/8/18.
//  Copyright © 2018 CVTC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: - Properties

  @IBOutlet weak var nameTextField: UITextField!
  
  @IBOutlet weak var eventNameLabel: UILabel!
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Handlethe text field's userinpt through dlegate callbacks.
    nameTextField.delegate = self
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
    eventNameLabel.text = textField.text
  }

  // MARK: - Actions
  
  @IBAction func setDefaultLabelText(_ sender: UIButton) {
    
    eventNameLabel.text = "Default Text"
  }
  
}

































