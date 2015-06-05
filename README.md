#Linked Notifications in Swift

Dynamic iOS style in-app notification system.

Used in Decode on the App Store<https://itunes.apple.com/us/app/decode-simple-qr-reader/id964303354?mt=8>

```swift
	var linkedNotifications = [LinkedNotification]()
        
    for (key, notification) in self.currentNotifications {
        var linkedNotif = LinkedNotification(id: notification.uniqueId)
        linkedNotif.tap = {
            //do something
        }
        linkedNotif.icon = UIImage(named: "iBeacon Notification Icon")
        linkedNotif.title = notification.title
        linkedNotif.detail = notification.detail
        linkedNotifications.append(linkedNotif)
    }

    LinkedNotification.shared.update(linkedNotifications, superView: self.view, topView: self.statusBarView)
```

Linked notifications will automatically re-arrange themselves as the underlying data model updates when `update` is called.