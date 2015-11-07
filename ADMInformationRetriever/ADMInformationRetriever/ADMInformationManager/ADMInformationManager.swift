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
	var servers: [ADMServer] = Array()
	var query: ADMQuery = ADMQuery()
	var results: [String] = Array()
	
//	init(endpointURL: String)
//	{
//		super.init()
//	}
//	init(url: String)
//	{
////		endpointURL = url
//		query = ADMQuery()
////		results = [NSDictionary]()
//		
//		super.init()
//	}
	
	init(mockFilename: String)
	{
		super.init()
		
		let mockServer = ADMServer(name: "offline", url: "localhost")
		self.servers = [mockServer]
		
		self.query = ADMQuery()
		self.results = Array()
		
		let bundle = NSBundle.mainBundle()
		let path = bundle.pathForResource("20151107_pubmed_mock", ofType: "json")
		let data:NSData = NSData(contentsOfFile: path!)!

		do
		{
			if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
			{
				print(jsonResult)
//				var results = jsonResult.objectForKey("results") as! String
				var result = getDocumentsForResult(jsonResult.objectForKey("results") as! [NSDictionary])
//				results.appendContentsOf(jsonResult.objectForKey("results") as! Array)
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
	
	func getDocumentsForResult(results: [NSDictionary]) -> [ADMDocument]
	{
		var arrayDocuments = [ADMDocument]()
		
		for dict in results
		{
//			var doc = ADMDocument
//			arrayDocuments.append(doc)
		}
		
		return arrayDocuments
	}
	
//	override var descripton : String
//	{
//		return "helloo"
//	}
	
}
