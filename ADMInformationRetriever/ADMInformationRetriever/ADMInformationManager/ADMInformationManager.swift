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
	var curServer: ADMServer = ADMServer(name: "", url: "")

    var query: ADMQuery = ADMQuery(query: "")
	var results: [String] = Array()
	
	init(mockFilename: String)
	{
		super.init()
		
		let cSharpServer = ADMServer(name: "C#", url: "http://dhbw-master.cloudapp.net/lucene/Service1.svc/")
		//http://dhbw-master.cloudapp.net/lucene/Service1.svc/query?search=authors%3ASaichanma&startIndex=0&length=10
		
		let bundle = NSBundle.mainBundle()
		let path = bundle.pathForResource("20151107_pubmed_mock", ofType: "json")

		let javaServer = ADMServer(name: "offline", url: path!)
		let mockServer = ADMServer(name: "offline", url: path!)

		
		self.servers = [cSharpServer, javaServer, mockServer]
		
		self.query = ADMQuery(query: "")
		self.results = Array()
		
//		sendQuery(self.query, server: self.servers[2], index: 0, length: 0)
	}
    
    func sendQuery(query: ADMQuery, server: ADMServer, index: Int, length: Int) -> Bool{
        return query.send(index, length: length, urlString: server.url)
    }
	
	typealias ManagerResponseBlock = (response:AnyObject?, totalResults: Int, error:NSError?) -> Void
	func sendQuery(query: ADMQuery, server: ADMServer, index: Int, length: Int, completionHandler: ManagerResponseBlock) -> Void
	{
		query.send(index, length: length, urlString: server.url, completionHandler: completionHandler)
	}
	
//	func send(index: Int, length: Int, urlString: String, completionHandler: QueryResponseBlock) -> Void
//	{
//		let url = NSURL(string: urlString)
//		let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
//			completionHandler(data: data, response: response, error: error)
//			print(NSString(data: data!, encoding: NSUTF8StringEncoding))
//		}
//		
//		task.resume()
//		//		completionHandler(response: <#T##AnyObject?#>, success: <#T##Bool?#>)
//	}

	
}
