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
		
		sendQuery(self.query, server: self.servers[0], index: 0, length: 0)
	}
    
    func sendQuery(query: ADMQuery, server: ADMServer, index: Int, length: Int) -> Bool{
        return query.send(index, length: length, urlString: server.url)
    }
	
}
