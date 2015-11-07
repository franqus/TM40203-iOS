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
		
//		self.manager.searchQuery(textField.text!)
	}
	
	@IBAction func btnSearch_tapped(sender: AnyObject)
	{
		print("\(__FUNCTION__)")
	}
	
	
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.manager.results.count
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

