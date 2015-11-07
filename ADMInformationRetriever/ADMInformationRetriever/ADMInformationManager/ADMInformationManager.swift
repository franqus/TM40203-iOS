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
	var query: String
	var results: Array<NSDictionary>
	
//	init(endpointURL: String)
//	{
//		super.init()
//	}
	init(url: String)
	{
		endpointURL = url
		query = ""
		results = [NSDictionary]()
		
		super.init()
	}
	
	init(mockFilename: String)
	{
		endpointURL = "foo"
		query = ""
		results = [NSDictionary]()
		
		let bundle = NSBundle.mainBundle()
		let path = bundle.pathForResource("mockdata", ofType: "json")
		let data:NSData = NSData(contentsOfFile: path!)!

		do
		{
			if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
			{
				print(jsonResult)
				query = jsonResult.objectForKey("query") as! String
				results.appendContentsOf(jsonResult.objectForKey("results") as! Array)
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