//
//  Alertable.swift
//  ToDone
//
//  Created by Michael Craun on 1/30/18.
//  Copyright © 2018 Craunic Productions. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices

enum AlertType {
    case none
    
    case iapDisabled
    case missingTitle
    case premiumRequired
    case recurringReminder
    
    var title: String {
        switch self {
        case .iapDisabled: return "In-App Purchases Disabled"
        case .missingTitle: return "Missing Title"
        case .premiumRequired: return "Premium Required"
        case .recurringReminder: return "Recurring Reminder"
        default: return "Error:"
        }
    }
    
    var message: String {
        switch self {
        case .iapDisabled: return "In-app purchases have been disabled. Please enable them to purchase."
        case .missingTitle: return "Your entry is missing a title."
        case .premiumRequired: return "You must have the premium features of ToDo ToDone to add more than 5 ToDo's or SubToDo's. Would you like to purchase?"
        case .recurringReminder: return "You are about to save this ToDo without a deadline. This will create a recurring reminder. Do you wish to continue?"
        default: return "There was an unexpected error. Please try again."
        }
    }
    
    var notificationType: NotificationType {
        switch self {
        default: return .error
        }
    }
    
    var needsOptions: Bool {
        switch self {
        case .premiumRequired: return true
        case .recurringReminder: return true
        default: return false
        }
    }
    
    var needsTextFields: Bool {
        switch self {
        default: return false
        }
    }
}

enum NotificationDevice {
    case haptic
    case vibrate
    case none
}

enum NotificationType {
    case error
    case success
    case warning
}

protocol Alertable {  }

extension Alertable where Self: UIViewController {
    func showAlert(_ alert: AlertType) {
        var defaultActionTitle: String {
            switch alert.needsOptions {
            case true: return "No"
            case false: return "OK"
            }
        }
        
        view.addBlurEffect()
        addVibration(withNotificationType: alert.notificationType)
        
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: defaultActionTitle, style: .default) { (action) in
            self.dismissAlert()
            
            if alert.needsTextFields {
                
            }
        }
        
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { (action) in
            self.dismissAlert()
            
            if alert == .premiumRequired {
                //TODO: perform segue to SettingsVC
            } else if alert == .recurringReminder{
                guard let vc = self as? AddToDoVC else { return }
                vc.scheduleReminder(recurring: true)
            }
        }
        
        if alert.needsTextFields {
            alertController.addTextField { (_) in
                
            }
            
            alertController.addTextField { (_) in
                
            }
        }
        
        alertController.addAction(defaultAction)
        if alert.needsOptions { alertController.addAction(yesAction) }
        
        present(alertController, animated: false, completion: nil)
    }
    
    func dismissAlert() {
        for subview in self.view.subviews {
            if subview.tag == 1001 {
                subview.fadeAlphaOut()
            }
        }
    }
    
    func addVibration(withNotificationType type: NotificationType) {
        var notificationDevice: NotificationDevice {
            switch UIDevice.current.modelName {
            case "iPhone 6", "iPhone 6 Plus", "iPhone 6s", "iPhone 6s Plus", "iPhone 7", "iPhone 7 Plus", "iPhone 8", "iPhone 8 Plus", "iPhone X": return .haptic
            case "iPod Touch 5", "iPod Touch 6", "iPhone 4", "iPhone 5", "iPhone 5c", "iPhone 5s", "iPhone SE": return .vibrate
            default: return .none
            }
        }
        
        switch notificationDevice {
        case .haptic:
            let notification = UINotificationFeedbackGenerator()
            switch type {
            case .error: notification.notificationOccurred(.error)
            case .success: notification.notificationOccurred(.success)
            case .warning: notification.notificationOccurred(.warning)
            }
        case .vibrate:
            let vibrate = SystemSoundID(kSystemSoundID_Vibrate)
            switch type {
            case .warning: AudioServicesPlaySystemSound(vibrate)
            default: break
            }
        default: break
        }
    }
}
