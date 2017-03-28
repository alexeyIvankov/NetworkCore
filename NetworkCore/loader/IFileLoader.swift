//
//  Uploader.swift
//
//  Created by Nikita on 12.07.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//

import Foundation

public typealias LoadCompletion = (_ data: Dictionary<String,Any>?, _ error: Error?)->Void
public typealias LoadCommand = (request:Request, parser:Parser?)
public typealias UploadCompletion = (_ data: Array<Any>?, _ error: Error?)->Void

public protocol IFileLoader : class
{
    func download(command:LoadCommand, completion: @escaping LoadCompletion) -> URLSessionDownloadTask?
    func download(command:LoadCommand, completion: @escaping LoadCompletion, completionQueue:DispatchQueue) -> URLSessionDownloadTask?
    
    func upload(command:LoadCommand, completion: @escaping UploadCompletion) -> URLSessionDataTask?
    func upload(command:LoadCommand, completion: @escaping UploadCompletion, completionQueue:DispatchQueue) -> URLSessionDataTask?
}
