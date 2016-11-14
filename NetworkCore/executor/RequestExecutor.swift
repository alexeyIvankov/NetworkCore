//
//  Executor.swift
//  mapissues_api_lib
//
//  Created by Nikita on 13.07.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//
import Foundation

public class RequestExecutor: IRequestExecutor {
    
    private let session:URLSession;
    
    required public init(session:URLSession) {
        self.session = session;
    }
    
    //MARK: IRequestExecutor
    public func execute(command:Command, completion:@escaping CompletionCommand) -> URLSessionDataTask?
    {
        let urlRequest:NSURLRequest? = NSURLRequest.create(request: command.request);
        var dataTask:URLSessionDataTask? = nil;
        
        if urlRequest == nil{
            completion(nil, NSError(domain: "failed convert IRequest to NSURLRequest", code: 0, userInfo: nil));
            return nil;
        }
        
        dataTask = self.session.dataTask(with: urlRequest! as URLRequest, completionHandler: { (data, response, error) in
            
            
            if error  != nil{
                completion(nil, error as NSError?);
            }
            else
            {
                if data == nil{
                    completion(nil, nil);
                }
                else
                {
                    let serializationData:AnyObject? = (try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as AnyObject?);
                    
                    if serializationData == nil
                    {
                        completion(nil, NSError(domain: "serialization json failed", code: 0, userInfo: nil))
                    }
                    else
                    {
                        if command.parser != nil
                        {
                            completion(command.parser!.parse(data: serializationData!), nil);
                        }
                        else
                        {
                            completion(Array(arrayLiteral: serializationData!), nil);
                        }
                    }
                }
            }
        })
        dataTask?.resume();
        
        return dataTask;
    }
    
    
    public func execute(command:Command, completion:@escaping CompletionCommand, completionQueue:DispatchQueue) -> URLSessionDataTask?
    {
        let task:URLSessionDataTask? = self.execute(command: command) { (data, error) in
            
            completionQueue.async(execute: {
                completion(data, error);
            })
        }
        
        task?.resume();
        
        return task;
    }

}
