//
//  CreateNotificationViewController.swift
//  LocalNotifications
//
//  Created by Yuliia Engman on 2/20/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit

protocol CreateNotificationControllerDelegate: AnyObject {
    func didCreateNotification(_ createNotificationController: CreateNotificationViewController)
}

class CreateNotificationViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: CreateNotificationControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.didCreateNotification(self)
    }
    
    
}
