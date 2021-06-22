//
//  Constants.swift
//  FileUpload
//
//  Created by gigas on 2021/06/09.
//

import Foundation

struct Constants {
    struct Base {
        // 서버 URL
        static let domain = "http://192.168.0.22:9091"
    }
}

extension String {
    var url: URL? {
        get {
            return URL(string: self)
        }
    }
}
