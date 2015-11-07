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
	
	
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		//return self.manager.results.count
        return documentsPerSection
	}
	
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSString string
    }
    
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		var cell:UITableViewCell = self.tvResults.dequeueReusableCellWithIdentifier("UITableViewCell")! as UITableViewCell
		
//		cell.textLabel?.text = self.items[indexPath.row]
        
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		
	}
	
	
	
}

