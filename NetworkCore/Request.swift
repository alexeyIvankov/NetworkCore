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
    case POST
    case GET
    case PUT
    case PATCH
    case DELETE
    case HEAD
    case TRACE
    case CONNECT
    
    var description: String
    {
        switch self
        {
        case .POST:		return "POST"
        case .GET:		return "GET"
        case .PUT:		return "PUT"
        case .PATCH:    return "PATCH"
        case .DELETE:	return "DELETE"
        case .HEAD:		return "HEAD"
        case .TRACE:	return "TRACE"
        case .CONNECT:	return "CONNECT"
        }
    }
}

public enum ContentTypeRequest : Int
{
    case JSON
    case STRING
    case BINARY
    case MULTIPART
}


public protocol Request : class
{
    func type() -> TypeRequest;
    func contentType() -> ContentTypeRequest;
    func url() -> NSURL;
    func parametrs() -> Dictionary<String, NSObject>?;
    func isLog() -> Bool;
}
