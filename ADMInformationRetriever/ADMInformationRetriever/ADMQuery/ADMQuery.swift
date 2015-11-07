//
//  ADMQuery.swift
//  ADMInformationRetriever
//
//  Created by Florian Panzer on 07.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMQuery: NSObject{
    var query: String
    var results: Array<ADMDocument> = [ADMDocument]()
    var totalResults: Int = 0
    var resultsPerPage: Int = 0
    
    init(query: String) {
        self.query = query
    }
    
    func send(index: Int, length: Int, urlString: String) -> Bool {
        let url: NSURL = NSURL.init(fileURLWithPath: urlString)
        let request: NSMutableURLRequest = NSMutableURLRequest.init(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: 10)
        request.HTTPMethod = "GET"

        do{
			let bundle = NSBundle.mainBundle()
			let path = bundle.pathForResource("20151107_pubmed_mock", ofType: "json")
			let data:NSData = NSData(contentsOfFile: path!)!
			
			do
			{
				if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
				{
					self.results = getDocumentsForResult(jsonResult.objectForKey("results") as! [NSDictionary])
				}
			}
			catch
			{
				print(error)
			}
			
			
        }
        catch { return false }
        return true
    }
	
	
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
}
