//
//  ServerCore.swift
//  ServerCoreSwift
//
//  Created by Ivankov Alexey on 29.04.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

public class NetworkCore
{
	
    private let mSession:URLSession
    private let mExecutor: RequestExecutor
    private let mLoader: FileLoader
	
	required public init(session:URLSession)
    {
		mSession = session
        mExecutor = RequestExecutor(session: mSession)
        mLoader = FileLoader(session: mSession)
	}
    
    public func executor() -> IRequestExecutor
    {
        return self.mExecutor
    }
    
    public func loader() -> IFileLoader
    {
        return self.mLoader
    }
}
