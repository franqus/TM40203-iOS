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
    var servers: Array<ADMServer> = [ADMServer]()
    

    var query: ADMQuery = ADMQuery()
	var results: [String] = Array()
	
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
    
    func sendQuery(query: ADMQuery, server: ADMServer, index: Int, length: Int) -> Bool{
        return query.send(index, length: length, url: server.url)
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
