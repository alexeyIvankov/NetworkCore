//
//  NSURLRequest+IRequest.swift
//  ServerCoreSwift
//
//  Created by Ivankov Alexey on 29.04.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

extension URLRequest
{
    static func create(request:Request) -> URLRequest
    {
        var urlRequest: URLRequest = URLRequest(url: request.url)

        if (request.contentType == ContentTypeRequest.string)
        {
            var hostUrl = request.url.absoluteString

            if request.type == .get, let queryString = request.parameters?.createQueryString()
            {
                hostUrl = hostUrl.appending("?").appending(queryString)
            }
            else
            {
                let post = request.parameters?.createQueryString()
                
                if  let postData = post?.data(using: String.Encoding.ascii, allowLossyConversion: true)
                {
                    let postLength:String = "\(postData.count)"
                    urlRequest.setValue(postLength, forHTTPHeaderField: "Content-Length")
                    urlRequest.httpBody = postData
                }
            }
            
            urlRequest.url = URL(string: hostUrl)
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
        else if (request.contentType == ContentTypeRequest.json), request.parameters != nil
        {
            let data = try? JSONSerialization.data(withJSONObject: request.parameters!, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        else if (request.contentType == ContentTypeRequest.multipart)
        {
            if let boundary = request.parameters?["boundary"], let data = request.parameters?["multipartData"] as? Data
            {
                urlRequest.httpBody = data
                urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            }
        }
        urlRequest.httpMethod = request.type.description
        return urlRequest
    }
}
