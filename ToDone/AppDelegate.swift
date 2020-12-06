//
//  AppDelegate.swift
//  ToDone
//
//  Created by Michael Craun on 10/6/17.
//  Copyright © 2017 Craunic Productions. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        return true
            
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { self.saveContext() }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "ToDone")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
                
            }
        })
        
        return container
        
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            
            do {
                
                try context.save()
                
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                
            }
        }
    }
    
    //MARK: UserNotification Functions
    func scheduleNotification(at date: Date, withToDo toDo: ToDo) {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current,
                                                 from: date)
        let newComponents = DateComponents(calendar: calendar,
                                           timeZone: .current,
                                           month: components.month,
                                           day: components.day,
                                           hour: 9,
                                           minute: 0)
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents,
                                                    repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = toDo.title!
        content.body = "You are \(toDo.completed)% done with this ToDo and it's due tomorrow! Let's make it a ToDone!"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "\(toDo.title!)", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    }
    
    func scheduleRecurringReminder(at date: Date, withToDo toDo: ToDo) {
        
        let calendar = Calendar(identifier: .gregorian)
        let newComponents = DateComponents(calendar: calendar,
                                           timeZone: .current,
                                           hour: 9,
                                           minute: 0,
                                           second: 0)
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents,
                                                    repeats: true)
        
        let content = UNMutableNotificationContent()
        content.title = toDo.title!
        content.body = "It's time to work on \(toDo.title!)! Let's make it a ToDone!"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "\(toDo.title!)",
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            
            if let error = error {
                
                print("Uh oh! We had an error: \(error)")
                
            }
        }
    }
    
    func removeNotification(withToDo toDo: ToDo) {
        
        //Removes UserNotifications that match the deleted ToDo
        let identifier = toDo.title!
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        
    }
}

let ad = UIApplication.shared.delegate as! AppDelegate
let context = ad.persistentContainer.viewContext
