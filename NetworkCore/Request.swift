//
//  IRequest.swift
//  ServerCoreSwift
//
//  Created by Ivankov Alexey on 29.04.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

public enum TypeRequest : Int
{
    case post
    case get
    case put
    case patch
    case delete
    case head
    case trace
    case connect

    var description: String
    {
        return String(describing: self).capitalized
    }
}

public enum ContentTypeRequest : Int
{
    case json
    case string
    case binary
    case multipart
}


public protocol Request : class
{
    var type: TypeRequest { get }
    var contentType: ContentTypeRequest { get }
    var url: URL { get }
    var parameters:  Dictionary<String, Any>? { get }
    var isLog: Bool { get }
    var extraHeaders: Dictionary<String, String>? { get }
}
