//
//  ADMQuery.swift
//  ADMInformationRetriever
//
//  Created by Florian Panzer on 07.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMQuery: NSObject{
    var query: String = ""
	var params: NSDictionary = NSDictionary()
    var results: Array<ADMDocument> = [ADMDocument]()
    var totalResults: Int = 0
    var resultsPerPage: Int = 0
	
	init(params: NSDictionary)
	{
		self.params = params
	}
	
    init(query: String)
	{
        self.query = query
    }
	
	typealias QueryResponseBlock = (results:AnyObject?, totalResults: Int, error:ErrorType?) -> Void

	func send(index: Int, length: Int, urlString: String, completionHandler: QueryResponseBlock) -> Void
	{
		self.query = urlString+self.buildQuery(self.params)
		let urlStr : NSString = self.query.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
		let url = NSURL(string: urlStr as String)
		
		if(NSURL(string: urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!.lastPathComponent == "20151107_pubmed_mock.json")
		{
			let data:NSData = NSData(contentsOfFile: urlString)!
			
			do
			{
				if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary
				{
					self.results = self.getDocumentsForResult(jsonResult.objectForKey("results") as! [NSDictionary])
					self.totalResults = self.results.count
					self.resultsPerPage = length
					
					completionHandler(results: self.results, totalResults: self.totalResults, error: nil)

				}
			}
			catch
			{
				completionHandler(results: nil, totalResults: 0, error: error)
				print(error)
			}
		}
		else
		{
			print("Sending request:\n"+(url?.absoluteString)!)
			
			let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
				
				if(error == nil)
				{
					do
					{
						if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
						{
							self.results = self.getDocumentsForResult(jsonResult.objectForKey("results")! as! [NSDictionary])
							self.totalResults = jsonResult.objectForKey("totalResults")! as! Int//self.results.count
							self.resultsPerPage = 10
							
							completionHandler(results: self.results, totalResults: self.totalResults, error: nil)
							
						}
					}
					catch
					{
						print(error)
						completionHandler(results: nil, totalResults: 0, error: error)
					}
				}
				else
				{
					completionHandler(results: nil, totalResults: 0, error: error)
				}
			}
			
			task.resume()
		}
	}
	
	
	func getDocumentsForResult(results: [NSDictionary]) -> [ADMDocument]
	{
		var arrayDocuments = [ADMDocument]()
		
		for dict in results
		{
			var arrayAuthors = [String]()
			for authorName in dict["authors"] as! Array<String>
			{
				arrayAuthors.append(authorName)
			}
			
			let doc = ADMDocument(jsonDict: dict)
			arrayDocuments.append(doc)
		}
		
		return arrayDocuments
	}
	
	func buildQuery(params: NSDictionary) -> String
	{
		var fullQuery: String = "query?"
		for (index, element) in params.allKeys.enumerate()
		{
			let stringKey = element as! String
			
			if(stringKey == "search")
			{
				var subQueryStr: String = "search="
				for (_, element) in (params["search"]?.allKeys.enumerate())!
				{
					let stringSubKey = element as! String
					let subKeyValue = params["search"]!.valueForKey(stringSubKey) as! String
					if(subKeyValue != "")
					{
						if(subQueryStr.characters.count > 7)
						{
							subQueryStr.appendContentsOf(" OR ")
						}
						subQueryStr.appendContentsOf( String(format: "%@:%@*", stringSubKey, subKeyValue) )
					}
					
				}
				fullQuery.appendContentsOf(subQueryStr)
			}
			else
			{
				if let keyValue = params.valueForKey(stringKey)
				{
					fullQuery.appendContentsOf( String(format: "%@=%@", stringKey, keyValue as! String) )
				}
			}
			
			if(index < params.allKeys.count-1)
			{
				fullQuery.appendContentsOf("&")
			}
		}
		
		return fullQuery
	}
}
