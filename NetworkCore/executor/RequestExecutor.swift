//
//  Executor.swift
//
//  Created by Nikita on 13.07.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//
import Foundation

public class RequestExecutor: IRequestExecutor
{
    
    private let session:URLSession
    
    required public init(session:URLSession)
    {
        self.session = session
    }
    
    //MARK: IRequestExecutor
    public func execute(command:Command, completion:@escaping CompletionCommand) -> URLSessionDataTask?
    {
        let urlRequest:URLRequest = URLRequest.create(request: command.request)
        var dataTask:URLSessionDataTask? = nil

        dataTask = self.session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in

            if error != nil
            {
                completion(nil, error)
            }
            else
            {
                if data == nil
                {
                    completion(nil, nil)
                }
                else
                {
                    if let serializationData: Any = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                    {
                        if command.parser != nil
                        {
                            completion(command.parser!.parse(data: serializationData), nil)
                        }
                        else
                        {
                            completion(Array(arrayLiteral: serializationData), nil)
                        }
                    }
                    else
                    {
                        completion(nil, NSError(domain: "serialization json failed", code: -1, userInfo: nil))
                    }
                }
            }
        })

        dataTask?.resume()
        
        return dataTask
    }
    
    
    public func execute(command:Command, completion:@escaping CompletionCommand, completionQueue:DispatchQueue) -> URLSessionDataTask?
    {
        let task: URLSessionDataTask? = self.execute(command: command) { (data, error) in
            
            completionQueue.async(execute:
            {
                completion(data, error)
            })
        }
        
        task?.resume()
        
        return task
    }

}
