//
//  LinkedNotification.swift
//  Decode
//
//  Created by Tanner Nelson on 4/3/15.
//

import UIKit

private let _shared = LinkedNotification()
class LinkedNotification {

    //MARK: Initializers
    init(id: String) {
        self.id = id
    }

    //MARK: Class functions
    class var shared: LinkedNotification {
        return _shared
    }

    //MARK: Properties
    var tap: (()->Void)?
    var title: String?
    var detail: String?
    var id: String?
    var icon: UIImage?

    var linkedNotificationViews = [String: LinkedNotificationView]()

    //MARK: Lifecycle
    func update(linkedNotifications: [LinkedNotification], superView: UIView, topView: UIView) {
        var removeKeys = [String]()
        
        for (key, view) in self.linkedNotificationViews {
            var found = false
            
            for notif in linkedNotifications {
                if key == notif.id! {
                    found = true
                }
            }
            
            if !found {
                view.hide()
                removeKeys.append(key)
            }
        }
        
        for key in removeKeys {
            self.linkedNotificationViews.removeValueForKey(key)
        }
        
        var lastView: UIView = topView
        
        for notif in linkedNotifications {
            if let view = self.linkedNotificationViews[notif.id!] {
                
                view.titleLabel.text = notif.title
                view.descriptionLabel.text = notif.detail
                view.onTap = notif.tap
                view.iconImageView.image = notif.icon
                
                view.moveUnderneath(view: lastView, shuffling: true)
                lastView = view
            } else {
                var view = LinkedNotificationView.instantiate()
                self.linkedNotificationViews[notif.id!] = view
                
                view.titleLabel.text = notif.title
                view.descriptionLabel.text = notif.detail
                view.onTap = notif.tap
                view.iconImageView.image = notif.icon
                
                view.addTo(superView, after: lastView)
                lastView = view
            }
        }
        
    }

}