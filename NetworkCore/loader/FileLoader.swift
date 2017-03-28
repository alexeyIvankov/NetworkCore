//
//  Uploader.swift
//
//  Created by Nikita on 13.07.16.
//  Copyright © 2016 Alexey Ivankov. All rights reserved.
//
import Foundation

public class FileLoader: IFileLoader
{
    private let session: URLSession

    required public init(session: URLSession)
    {
        self.session = session
    }

    public func download(command: LoadCommand, completion: @escaping LoadCompletion) -> URLSessionDownloadTask?
    {
        let urlRequest: URLRequest = URLRequest.create(request: command.request)

        var dataTask: URLSessionDownloadTask? = nil

        dataTask = self.session.downloadTask(with: urlRequest, completionHandler: { (data, response, error) in

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
                    completion(["filePath": data! as AnyObject], nil)
                }
            }

        })

        dataTask?.resume()
        return dataTask
    }

    public func download(command: LoadCommand, completion: @escaping LoadCompletion, completionQueue: DispatchQueue) -> URLSessionDownloadTask?
    {
        let task: URLSessionDownloadTask? = self.download(command: command) { (data, error) in

            completionQueue.async(execute:
            {
                completion(data, error)
            })
        }

        task?.resume()

        return task
    }


    public func upload(command: LoadCommand, completion: @escaping UploadCompletion) -> URLSessionDataTask?
    {
        let urlRequest: URLRequest = URLRequest.create(request: command.request);
        var dataTask: URLSessionDataTask? = nil

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
                        completion(nil, RequestError(rawValue: 0))// Error(domain: "serialization json failed", code: 0, userInfo: nil))
                    }
                }
            }

        })
        dataTask?.resume()

        return dataTask
    }


    public func upload(command: LoadCommand, completion: @escaping UploadCompletion, completionQueue: DispatchQueue) -> URLSessionDataTask?
    {
        let task: URLSessionDataTask? = self.upload(command: command) { (data, error) in

            completionQueue.async
            {
                completion(data, error)
            }
        }

        task?.resume()

        return task
    }
}
