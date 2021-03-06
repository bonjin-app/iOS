//
//  FileUploadProvider.swift
//  FileUpload
//
//  Created by gigas on 2021/06/09.
//

import Foundation
import Alamofire
import MobileCoreServices

class FileUploadProvider {
    
    static let shared = { FileUploadProvider() }()
    
    static let API_UPLOAD = "/api/upload"
    
    static let FILE_UPLOAD_KEY = "files"
    
    init() {
        print("FileUploadProvider init")
    }
    
    func requestFileUploadAlamofire(parameters: Parameters, fileData: Data, fileName: String, mimeType: String,
                           progressHandler: ((Progress) -> Void)?,
                           successHandler: @escaping (AFDataResponse<Data?>) -> Void) {
        guard let url = URL(string: FileUploadProvider.API_UPLOAD, relativeTo: Constants.Base.domain.url) else {
            return
        }
        
        AF.upload(multipartFormData: { multipart in
            for (key, value) in parameters {
                multipart.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            multipart.append(fileData, withName: FileUploadProvider.FILE_UPLOAD_KEY, fileName: fileName, mimeType: mimeType)
            
        }, to: url, method: .post)
        .uploadProgress { progress in
            progressHandler?(progress)
            
        }.response { response in
            successHandler(response)
        }
    }
}
