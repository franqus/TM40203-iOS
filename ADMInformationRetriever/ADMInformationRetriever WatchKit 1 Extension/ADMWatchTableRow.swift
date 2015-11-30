//
//  ADMWatchTableRow.swift
//  ADMInformationRetriever
//
//  Created by Florian Panzer on 23.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

//import UIKit
import WatchKit

class ADMWatchTableRow: NSObject {

    @IBOutlet var group : WKInterfaceGroup!
    @IBOutlet var label : WKInterfaceLabel!
    var document : ADMDocument!
    
    func assignDocument(document : ADMDocument){
        self.document = document
        label.setAttributedText(NSAttributedString(string: self.document.title!))
    }

}
