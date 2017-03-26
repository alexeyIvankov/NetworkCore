//
//  ServerCoreProtocol.swift
//  GeoTasks
//
//  Created by Ivankov Alexey on 10.11.15.
//  Copyright © 2015 Ivankov Alexey. All rights reserved.
//

import Foundation

public typealias CompletionCommand = (_ data: Array<Any>?, _ error:Error?)->Void;
public typealias Command = (request:Request, parser:Parser?);

public protocol IRequestExecutor : class
{
    func execute(command:Command, completion:@escaping CompletionCommand) -> URLSessionDataTask?;
    func execute(command:Command, completion:@escaping CompletionCommand, completionQueue:DispatchQueue) -> URLSessionDataTask?;
}
