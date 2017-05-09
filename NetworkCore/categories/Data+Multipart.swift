//
//  Data+Multipart.swift
//  multibank_api_lib_ios
//
//  Created by Nikita on 08.05.17.
//  Copyright © 2017 Multibank. All rights reserved.
//

import Foundation

extension Data
{
    static func createUploadBody(data: Data, mimeType: String, fileParamName: String, fileName: String, boundary: String) -> Data
    {
        var body = Data()
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(fileParamName)\"; filename=\"\(fileName)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--\(boundary)--\r\n")
        return body as Data
    }
    
    mutating func appendString(_ string: String)
    {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
