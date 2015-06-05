#Linked Notifications in Swift

Dynamic iOS style in-app notification system.

As seeon in Decode on the App Store <https://itunes.apple.com/us/app/decode-simple-qr-reader/id964303354?mt=8>

```swift
var linkedNotifications = [LinkedNotification]()
    
for (key, example) in examples {
    var linkedNotif = LinkedNotification(id: example.uniqueId)
    linkedNotif.tap = {
        //do something
    }
    linkedNotif.icon = UIImage(named: "iBeacon Notification Icon")
    linkedNotif.title = example.title
    linkedNotif.detail = example.detail
    linkedNotifications.append(linkedNotif)
}

LinkedNotification.shared.update(linkedNotifications, superView: self.view, topView: self.statusBarView)
```
Linked notifications will automatically re-arrange themselves as the underlying data model updates when `update` is called.

##Example Notification Model

For clarity, here is the model behind the `examples` variable
```swift
class ExampleNotification {
	var uniqueId: String,
	var title: String,
	var desc: String

	init(id: String, title: String, desc: String) {
		self.uniqueId = id;
		self.title = title;
		self.desc = desc;
	}
}
var examples = [
	ExampleNotification(1, title: "First Notification", "Tap me"),
	ExampleNotification(1, title: "Second Notification", "Tap me, too")
];
```		
