//
//  ADMQuery.swift
//  ADMInformationRetriever
//
//  Created by Florian Panzer on 07.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMQuery: NSObject {
    var query: String
    var results: Array<ADMDocument> = [ADMDocument]()
    var totalResults: Int = 0
    var resultsPerPage: Int = 0
    
    init(query: String) {
        self.query = query
    }
    
    func send(index: Int, length: Int, urlString: String) -> Bool {
        let url: NSURL = NSURL.init(fileURLWithPath: urlString)
        var request: NSMutableURLRequest = NSMutableURLRequest.init(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: 10)
        request.HTTPMethod = "GET"
        var response: NSURLResponse
        var connection: NSURLConnection
        NSURLConnection.start(connection)
        return true
    }
}
