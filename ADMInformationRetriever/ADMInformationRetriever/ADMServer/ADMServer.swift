//
//  ADMServer.swift
//  ADMInformationRetriever
//
//  Created by Florian Panzer on 07.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMServer: NSObject {
    var name: String
    var url: String
    
    init(name: String, url: String){
        self.url = url
        self.name = name
    }

}
