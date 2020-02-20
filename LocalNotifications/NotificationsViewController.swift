//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Yuliia Engman on 2/20/20.
//  Copyright © 2020 Yuliia Engman. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var notifications = [String]()
    
    private let center =
        UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        checkForNotificationAuthorization()
    }
    
    private func checkForNotificationAuthorization() {
        center.getNotificationSettings {(settings) in
            if settings.authorizationStatus == .authorized {
                print("app is authorized for notifications")
            }else {
                self.reqestNotificationPermissions()
            }
        }
    }
    
    private func reqestNotificationPermissions() {
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if let error = error {
                print("error requesting authorization: \(error)")
                return
            }
            if granted {
                print("access was granted")
            } else {
                print("access denied")
            }
        }
    }
}


extension NotificationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return notifications.count
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        return cell
    }
    
    
}
