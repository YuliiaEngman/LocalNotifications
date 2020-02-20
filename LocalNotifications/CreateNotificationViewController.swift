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
    
    private var timeInterval: TimeInterval = Date().timeIntervalSinceNow + 5 // current time plus 5 seconds
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func createLicalNotification() {
        // step 1: create the content
        // contect like a Model for notification
        let content = UNMutableNotificationContent()
        content.title = titleTextField.text ?? "No title"
        content.body = "Local Notifications is awesome when used appropriatly"
        content.subtitle = "Learning Local Notifications"
        
        // step 2: create identifier
        // if I would use 1 notification we could hardcode the ID for htat
        let identifier = UUID().uuidString // using String
        
        // attachment
        // we did not put image to assets folder but just added to project (in assets it will not see it)
        if let imageURL = Bundle.main.url(forResource: "Unknown", withExtension: "jpeg") {
            do {
                let attachment = try UNNotificationAttachment(identifier: identifier, url: imageURL, options: nil)
                content.attachments = [attachment]
            } catch {
                print("error with attachment: \(error)")
            }
        } else {
            print("image resource could not be found")
        }
        
        // create trigger: 3 options (timeInterval, calendar, location)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        // create a request
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // nor we are adding request to the UNNotificationCenter
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("error adding request: \(error)")
            } else {
                print("request was succesfully added")
            }
    }
    }
    

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        // using this line of code to avoid time being in the past
        guard sender.date > Date() else { return }
        //timeIntervalSinceNow creates a time stamp of the exact date
        timeInterval = sender.date.timeIntervalSinceNow
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.didCreateNotification(self)
    }
    
    
}
