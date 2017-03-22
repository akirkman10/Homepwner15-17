//
//  DateViewController.swift
//  Homepwner
//
//  Created by Alexis Kirkman on 3/21/17.
//  Copyright © 2017 Alexis Kirkman. All rights reserved.
//

import UIKit

class DateViewController: UIViewController{
   @IBOutlet var chooseDate: UIDatePicker!
   var item: Item!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      navigationItem.title = "Date Created"
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      item.dateCreated = chooseDate.date
   }
}
