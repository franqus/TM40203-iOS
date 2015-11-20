//
//  ADMDocument.swift
//  ADMInformationRetriever
//
//  Created by Florian Panzer on 07.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMDocument: NSObject {
    var id: Int
    var journal: String
    var title: String
    var authors: Array<ADMAuthor> = [ADMAuthor]()
    var institutions: String
    var abstract: String
    var pmid: String
    var url: String
    var rank: Float
    
	init(id: Int, journal: String, title: String, authors: Array<ADMAuthor>, institutions: String, abstract: String, pmid: String, url: String, rank: Float){
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
	
	override init() {
		self.id = 0
		self.journal = ""
		self.title = ""
		self.institutions = ""
		self.abstract = ""
		self.pmid = ""
		self.url = ""
		self.rank = 0
	}
	
	override var description:String {
		return String(format: "id:%i \n journal:%@ \n title:%@ \n authors:%@ \n institutions:%@ \n abstract:%@ \n pmid:%@ \n ranking:%f", self.id, self.journal, self.title, self.authors, self.institutions, self.abstract, self.pmid, self.rank)
	}
}
