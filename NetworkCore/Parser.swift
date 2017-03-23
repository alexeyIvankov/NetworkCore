//
//  IModelMapper.swift
//  ServerCoreSwift
//
//  Created by Ivankov Alexey on 29.04.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

public protocol Parser : class
{
    func parse(data:AnyObject) -> Array<AnyObject>?
}