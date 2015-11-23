//
//  InterfaceController.swift
//  ADMInformationRetriever WatchKit 1 Extension
//
//  Created by Florian Panzer on 23.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var table : WKInterfaceTable!
    let documentsPerSection: String = "10"
    var manager: ADMInformationManager!
    var results: Array<ADMDocument> = [ADMDocument]()
    var totalResults: Int = 0

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.manager = ADMInformationManager(mockFilename: "mockdata")
        self.manager.curServer = self.manager.servers[0]
        
        let searchtext = "test"
        let paramDict: NSDictionary =
               ["length":self.documentsPerSection,
                "startIndex":"0",
                "search":["journal":searchtext,
                    "authors":searchtext,
                    "title":searchtext,
                    "institutions":searchtext,
                    "abstract":searchtext]]
        
        let query: ADMQuery = ADMQuery.init(params: paramDict)
        self.manager.sendQuery(query, server: self.manager.curServer, index: 0, length: Int(self.documentsPerSection)!) { (response, totalResults, error) -> Void in
            
            if(error == nil)
            {
                self.results = response as! Array<ADMDocument>
                self.totalResults = totalResults
                self.receiveResults()
                
                dispatch_async(dispatch_get_main_queue())
                    {
                        print("hhh")
                        //self.aiRequest.stopAnimating()
                        //self.btnGo.hidden = false
                        //self.tvResults.reloadData()
                }
            }
            else
            {
                dispatch_async(dispatch_get_main_queue())
                    {
                        //self.aiRequest.stopAnimating()
                        //self.btnGo.hidden = false
                }
                print("error=%@",error)
            }
        }

    }
    
    func receiveResults(){
        self.table.setNumberOfRows(results.count,withRowType: "ADMWatchTableRow")
        for(var i=0; i<results.count; i++){
            let row : ADMWatchTableRow = self.table.rowControllerAtIndex(i) as! ADMWatchTableRow
            row.assignDocument(results[i])
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
