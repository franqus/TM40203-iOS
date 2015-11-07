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
    
    init(id: Int, journal: String, title: String, institutions: String, abstract: String, pmid: String, url: String, rank: Float){
        self.id = id
        self.journal = journal
        self.title = title
        self.institutions = institutions
        self.abstract = abstract
        self.pmid = pmid
        self.url = url
        self.rank = rank
    }
}
