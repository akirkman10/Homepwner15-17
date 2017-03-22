//
//  customTextField.swift
//  Homepwner
//
//  Created by Alexis Kirkman on 3/21/17.
//  Copyright © 2017 Alexis Kirkman. All rights reserved.
//

import UIKit

class customTextField: UITextField{
   
   override func becomeFirstResponder() -> Bool {
      super.becomeFirstResponder()
      
      self.borderStyle = .line
      return true
   }
   
   override func resignFirstResponder() -> Bool {
      super.resignFirstResponder()
      
      self.borderStyle = .roundedRect
      return true
   }
}
