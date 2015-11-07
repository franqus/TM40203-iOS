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
    

    var query: ADMQuery = ADMQuery(query: "")
	var results: [String] = Array()
	
	init(mockFilename: String)
	{
		super.init()
		
		let mockServer = ADMServer(name: "offline", url: "localhost")
		self.servers = [mockServer]
		
		self.query = ADMQuery(query: "")
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
				let result = getDocumentsForResult(jsonResult.objectForKey("results") as! [NSDictionary])
				print(result)
				
//				results.appendContentsOf(jsonResult.objectForKey("results") as! Array)
			}
		}
		catch
		{
			print(error)
		}
	}
    
//    func sendQuery(query: ADMQuery, server: ADMServer, index: Int, length: Int) -> Bool{
//        return query.send(index, length: length, url: server.url)
//    }
	
	func getDocumentsForResult(results: [NSDictionary]) -> [ADMDocument]
	{
		var arrayDocuments = [ADMDocument]()
		
		for dict in results
		{
			let doc = ADMDocument(id: dict["id"]! as! Int, journal: dict["journal"] as! String, title: dict["title"] as! String, authors: dict["authors"] as! Array<ADMAuthor>, institutions: dict["institutions"] as! String, abstract: dict["abstract"] as! String, pmid: dict["pmid"] as! String, url: "http://hcbi.nlm.nih.gov/pubmed/?term=", rank: dict["ranking"] as! Float)
			arrayDocuments.append(doc)
		}
		
		return arrayDocuments
	}
	
//	override var descripton : String
//	{
//		return "helloo"
//	}
	
}
