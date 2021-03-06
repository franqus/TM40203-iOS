//
//  ADMDocument.swift
//  ADMInformationRetriever
//
//  Created by Florian Panzer on 07.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMDocument: NSObject {
    var id: String?
	var journal: String?
    var title: String?
    var authors: Array<String> = [String]()
    var institutions: String?
    var abstract: String?
    var pmid: String?
    var url: String?
    var rank: Float?
    
	init(id: String, journal: String, title: String, authors: Array<String>, institutions: String, abstract: String, pmid: String, url: String, rank: Float){
		self.id = id
        self.journal = journal
		self.title = title
		self.authors = authors
        self.institutions = institutions
        self.abstract = abstract
        self.pmid = pmid
        self.url = url
        self.rank = rank
    }
	
	init(jsonDict: NSDictionary)
	{
		self.id = jsonDict["id"] as? String
		self.journal = jsonDict["journal"] as? String
		self.title = jsonDict["title"] as? String
		authors = jsonDict["authors"] as! Array<String>
		institutions = jsonDict["institutions"] as? String
		abstract = jsonDict["abstract"] as? String
		self.pmid = jsonDict["pmid"] as? String
		self.url = "http://hcbi.nlm.nih.gov/pubmed/?term="
		self.rank = (jsonDict["ranking"] as! Float)
	}
	
	
	override init() {
		self.id = ""
		self.journal = ""
		self.title = ""
		self.institutions = ""
		self.abstract = ""
		self.pmid = ""
		self.url = ""
		self.rank = 0
	}
	
	override var description:String {
		return String(format: "id:%i \n journal:%@ \n title:%@ \n authors:%@ \n institutions:%@ \n abstract:%@ \n pmid:%@ \n ranking:%f", self.id!, self.journal!, self.title!, self.authors, self.institutions!, self.abstract!, self.pmid!, self.rank!)
	}
}
