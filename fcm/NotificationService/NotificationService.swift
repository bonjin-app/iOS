//
//  NotificationService.swift
//  NotificationService
//
//  Created by gigas on 2021/04/16.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    // MARK: - Default
//    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
//        self.contentHandler = contentHandler
//        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
//
//        if let bestAttemptContent = bestAttemptContent {
//            // Modify the notification content here...
//            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
//
//            contentHandler(bestAttemptContent)
//        }
//    }
    
    // MARK: - UNNotificationAttachment Extension
//    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
//        self.contentHandler = contentHandler
//        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
//        defer {
//            contentHandler(bestAttemptContent ?? request.content)
//        }
//        let fcm_options = request.content.userInfo["fcm_options"] as? [String : Any]
//        let imageUrl = fcm_options?["image"] as? String
//        if let imgUrl = imageUrl {
//            if let attachment = parseAttachment(imageUrl: imgUrl) {
//                bestAttemptContent?.attachments = [attachment]
//                return
//            }
//        }
//    }
    
    // MARK: - Image Function
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        if let bestAttemptContent = bestAttemptContent {
            bestAttemptContent.title = "\(bestAttemptContent.title) [modified]"
            
            let fcm_options = request.content.userInfo["fcm_options"] as? [String : Any]
            if let imageURLString = fcm_options?["image"] as? String {
                if let imagePath = self.image(imageURLString) {
                    let imageURL = URL(fileURLWithPath: imagePath)
                    if let attachment = try? UNNotificationAttachment(identifier: "image-test", url: imageURL, options: nil) {
                        bestAttemptContent.attachments = [attachment]
                        return
                    }
                }
            }
            contentHandler(bestAttemptContent)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}

extension NotificationService {
    func image(_ URLString: String) -> String? {
        let componet = URLString.components(separatedBy: "/")
        if let fileName = componet.last {
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            if let documentsPath = paths.first {
                
                let filePath = documentsPath.appending("/" + fileName)
                if let imageURL = URL(string: URLString) {
                    do {
                        let data = try NSData(contentsOf: imageURL, options: NSData.ReadingOptions(rawValue: 0))
                        if data.write(toFile: filePath, atomically: true) {
                            return filePath
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        return nil
    }
    
    func parseAttachment(imageUrl: String) -> UNNotificationAttachment? {
        if let imageData = try? Data(contentsOf: URL(string: imageUrl)!) {
            return try? UNNotificationAttachment(data: imageData, options: nil)
        }
        
        return nil
    }
}

extension UNNotificationAttachment {
    convenience init(data: Data, options: [NSObject: AnyObject]?) throws {
        let fileManager = FileManager.default
        let temporaryFolderName = ProcessInfo.processInfo.globallyUniqueString
        let temporaryFolderURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(temporaryFolderName, isDirectory: true)
 
        try fileManager.createDirectory(at: temporaryFolderURL, withIntermediateDirectories: true, attributes: nil)
        let imageFileIdentifier = UUID().uuidString + ".jpg"
        let fileURL = temporaryFolderURL.appendingPathComponent(imageFileIdentifier)
        try data.write(to: fileURL)
        try self.init(identifier: imageFileIdentifier, url: fileURL, options: options)
    }
}
