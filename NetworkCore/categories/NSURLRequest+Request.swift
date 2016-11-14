//
//  NSURLRequest+IRequest.swift
//  ServerCoreSwift
//
//  Created by Ivankov Alexey on 29.04.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

extension NSURLRequest
{
    class func create(request:Request) -> NSURLRequest?
    {
        let urlRequest:NSMutableURLRequest = NSMutableURLRequest();
        urlRequest.url = request.url() as URL;
        if  request.parametrs() != nil
        {
            if (request.contentType() == ContentTypeRequest.STRING)
            {
                urlRequest.url = NSURL(string: (request.url().absoluteString?.appending("?").appending((request.parametrs()?.createQueryString())!))!) as URL?
                urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"content-type")
                
            }
            else if (request.contentType() == ContentTypeRequest.JSON)
            {
                let data = try? JSONSerialization.data(withJSONObject: request.parametrs()!, options:JSONSerialization.WritingOptions.init(rawValue: 0));
                urlRequest.httpBody = data
                urlRequest.setValue("application/json", forHTTPHeaderField:"content-type")
            }
            else if (request.contentType() == ContentTypeRequest.MULTIPART)
            {
                urlRequest.httpBody = request.parametrs()!["multipartData"] as? NSData as Data?
                urlRequest.setValue("multipart/form-data; boundary=\(request.parametrs()!["boundary"]!)", forHTTPHeaderField: "Content-Type")
            }
        }
        
        urlRequest.httpMethod = request.type().description;
        
        return urlRequest;
    }
}
