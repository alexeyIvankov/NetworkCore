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
	
    let session:URLSession
    let executor: RequestExecutor
    let loader: FileLoader

	required public init(session:URLSession)
    {
		self.session = session
        executor = RequestExecutor(session: session)
        loader = FileLoader(session: session)
	}
}
