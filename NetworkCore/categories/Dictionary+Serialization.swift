//
//  Dictionary+Serialization.swift
//  ServerCoreSwift
//
//  Created by Ivankov Alexey on 29.04.16.
//  Copyright © 2016 Ivankov Alexey. All rights reserved.
//

import Foundation

extension Dictionary
{
	func createQueryString() -> String?
	{
		var pairs:Array<String> = Array();
		
		for (key, value) in self
		{
			if let object = value as Any?
			{
				let stringValue:String? = self.stringFrom(object: object)
				if (stringValue != nil)
				{
					pairs.append("\(key)=\(stringValue!)");
				}
			}
		}
		return pairs.joined(separator: "&")
	}
	
	private func stringFrom(object:Any) -> String?
	{
		var string:String?;
		
		if (object is Dictionary) || (object is Array<String>)
		{
			do
			{
				let jsonData = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions.init(rawValue: 0))
                
				let jsonString = String(bytes: jsonData, encoding: .utf8)
				
				string = self.escaped(string: jsonString)
			}
			catch{
				
			}
		}
		else
		{
			string = self.escaped(string: String(describing: object));
		}
		return string;
	}
	
	private func escaped(string:String?) -> String?
	{
		return string?.addingPercentEscapes( using: String.Encoding.utf8)
	}
    
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
