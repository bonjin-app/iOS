//
//  URL+Extension.swift
//  FileUpload
//
//  Created by gigas on 2021/06/09.
//

import Foundation
import MobileCoreServices

extension URL {
    var mimeType: String {
        get {
            let pathExtension = self.pathExtension
            if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                               pathExtension as NSString,
                                                               nil)?.takeRetainedValue() {
                if let type = UTTypeCopyPreferredTagWithClass(uti,
                                                              kUTTagClassMIMEType)?.takeRetainedValue() {
                    return type as String
                }
            }
            return "application/octet-stream"
        }
    }
}
