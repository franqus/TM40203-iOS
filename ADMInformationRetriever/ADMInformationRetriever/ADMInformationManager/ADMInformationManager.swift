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
		let javaServer = ADMServer(name: "Java", url: "http://185.44.105.219:8080/ADM-Java-Service/lucene/")

		let bundle = NSBundle.mainBundle()
		let path = bundle.pathForResource("20151107_pubmed_mock", ofType: "json")
		let mockServer = ADMServer(name: "offline", url: path!)
		
		self.servers = [cSharpServer, javaServer, mockServer]
		
		self.query = ADMQuery(query: "")
		self.results = Array()

	}
	
	typealias ManagerResponseBlock = (response:AnyObject?, totalResults: Int, error:ErrorType?) -> Void
	func sendQuery(query: ADMQuery, server: ADMServer, index: Int, length: Int, completionHandler: ManagerResponseBlock) -> Void
	{
		query.send(index, length: length, urlString: server.url, completionHandler: completionHandler)
	}
}