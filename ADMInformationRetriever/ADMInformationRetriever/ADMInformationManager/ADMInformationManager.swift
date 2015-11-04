//
//  ADMInformationManager.swift
//  ADMInformationRetriever
//
//  Created by Frank Schmitt on 04.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMInformationManager: NSObject
{
	var endpointURL: String
	
//	init(endpointURL: String)
//	{
//		super.init()
//	}
	init(url: String)
	{
		endpointURL = url
		super.init()
	}
	
	init(mockFilename: String)
	{
		endpointURL = "foo"
		
		let bundle = NSBundle.mainBundle()
		let path = bundle.pathForResource("mockdata", ofType: "json")
		let data:NSData = NSData(contentsOfFile: path!)!

		do
		{
			if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
			{
				print(jsonResult)
			}
		}
		catch
		{
			print(error)
		}
	}
	
	func searchQuery(query: String)
	{
		print("foo")
	}
	
//	override var descripton : String
//	{
//		return "helloo"
//	}
	
}
