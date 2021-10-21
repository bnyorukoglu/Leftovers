//
//  LocalNotificationManager.swift
//  LeftoversApp
//
//  Created by 109895 on 20.10.2021.
//

import Foundation

import SwiftUI

class LocalNotificationManager: ObservableObject {
    
    var notifications = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                
            }
        }
    }
    
    func sendNotification(title: String, subtitle: String?, body: String, launchIn: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        content.body = body
        
        
        
      
        // *** create calendar object ***
        var calendar = Calendar.current
        
        // *** Get components using current Local & Timezone ***
     
        let date =  calendar.date(byAdding: Calendar.Component.minute, value: -5, to: launchIn) ?? Date()
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date) ;
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        // *** Get All components from date ***
       
     
        
        
        // Create the trigger as a repeating event.
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: "TO_DO_APP_NOTIFICATIN", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
