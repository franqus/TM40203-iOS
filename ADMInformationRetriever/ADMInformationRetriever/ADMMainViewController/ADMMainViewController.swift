//
//  ViewController.swift
//  ADMInformationRetriever
//
//  Created by Frank Schmitt on 04.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMMainViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource
{
	
	@IBOutlet weak var tfSearch: UITextField!
	@IBOutlet weak var tvResults: UITableView!
	var manager: ADMInformationManager!
    let documentsPerSection: Int = 10
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		manager = ADMInformationManager(mockFilename: "mockdata")
		print(manager)
	}

	override func viewWillAppear(animated: Bool) {
		self.navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func textFieldDidEndEditing(textField: UITextField)
	{
		print("\(__FUNCTION__)")
		
	}
	
	@IBAction func btnSearch_tapped(sender: AnyObject)
	{
        let query: ADMQuery = ADMQuery.init(query: tfSearch.text!)
        self.manager.sendQuery(query, server: self.manager.servers.first!, index: 0, length: documentsPerSection)
        self.tvResults.reloadData()
	}
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.manager.query.totalResults/documentsPerSection
    }
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
        let followingDocs: Int = self.manager.query.totalResults-section*documentsPerSection
        return min(followingDocs,documentsPerSection)
	}
	
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(format: "%i", section*documentsPerSection)
    }
    
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell:UITableViewCell = self.tvResults.dequeueReusableCellWithIdentifier("UITableViewCell")! as UITableViewCell
		
        let docNum: Int = indexPath.section*documentsPerSection+indexPath.row
        var lastDocNum: Int = self.manager.query.results.count-1
        
        var document: ADMDocument
        
        while(docNum>lastDocNum){
            self.manager.sendQuery(self.manager.query, server: self.manager.servers.first!, index: lastDocNum+1, length: documentsPerSection)
            lastDocNum = self.manager.query.results.count-1
        }
        
        document = self.manager.query.results[docNum]
        
		cell.textLabel?.text = document.title
        
		return cell
	}
	
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 20
	}
	
//	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//	{
//		
//	}
	
}