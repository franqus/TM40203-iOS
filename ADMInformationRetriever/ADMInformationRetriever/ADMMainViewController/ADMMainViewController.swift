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
	@IBOutlet weak var scSource: UISegmentedControl!
	@IBOutlet weak var btnGo: UIButton!
	@IBOutlet weak var aiRequest: UIActivityIndicatorView!
	
	var manager: ADMInformationManager!
    let documentsPerSection: String = "1000"
	var results: Array<ADMDocument> = [ADMDocument]()
	var totalResults: Int = 0
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		manager = ADMInformationManager(mockFilename: "mockdata")
		
		self.manager.curServer = self.manager.servers[self.scSource.selectedSegmentIndex]

		self.btnGo.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
		
		self.tfSearch.becomeFirstResponder()
//		print(manager)
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}

	override func viewWillAppear(animated: Bool) {
		self.navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func didReceiveMemoryWarning()
	{
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		
		if(range.location == 0)
		{
			self.btnGo.enabled = false
		}
		else
		{
			self.btnGo.enabled = true
		}
		
		return true
	}
	
	func textFieldDidEndEditing(textField: UITextField)
	{
		print("\(__FUNCTION__)")
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool
	{
		textField.resignFirstResponder()
		self.btnSearch_tapped(self.btnGo)
		return true
	}
	
	@IBAction func btnSearch_tapped(sender: AnyObject)
	{
		if(self.tfSearch.text == nil || self.tfSearch.text == "")
		{
			return
		}
		
		let paramDict = ["length":self.documentsPerSection,
						"startIndex":"0",
						"search":["journal":self.tfSearch.text!,
							"authors":self.tfSearch.text!,
							"title":self.tfSearch.text!,
							"institutions":self.tfSearch.text!,
							"abstract":self.tfSearch.text!]]

		let query: ADMQuery = ADMQuery.init(params: paramDict)
//		let query: ADMQuery = ADMQuery.init(query: self.tfSearch.text!)
//        self.manager.sendQuery(query, server: self.manager.curServer, index: 0, length: self.documentsPerSection)
		
		
		self.aiRequest.startAnimating()
		self.btnGo.hidden = true
		self.manager.sendQuery(query, server: self.manager.curServer, index: 0, length: Int(self.documentsPerSection)!) { (response, totalResults, error) -> Void in
			self.results = response as! Array<ADMDocument>
			self.totalResults = totalResults
			
			dispatch_async(dispatch_get_main_queue())
			{
				self.aiRequest.stopAnimating()
				self.btnGo.hidden = false
				self.tvResults.reloadData()
			}
				
		}
	}
	
	@IBAction func segmentedControl_changed(sender: UISegmentedControl)
	{
		self.manager.curServer = self.manager.servers[sender.selectedSegmentIndex]
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.totalResults
//        let followingDocs: Int = self.totalResults-section*self.documentsPerSection//self.manager.query.totalResults-section*documentsPerSection
//        return min(followingDocs, self.documentsPerSection)
	}
	
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return String(format: "%i", section*self.documentsPerSection)
		var headerStr: String = String(format: "   %i Results", self.totalResults)
		if(self.totalResults == 1000)
		{
			headerStr = String(format: "   %i+ Results", self.totalResults)
		}
		return headerStr
    }
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell:ADMMainViewResultTableViewCell = self.tvResults.dequeueReusableCellWithIdentifier("UITableViewMainResultCell")! as! ADMMainViewResultTableViewCell
		
        var document: ADMDocument
        document = self.results[indexPath.row]
		
		cell.lblRank.text = String(format: "%.3f", document.rank)
		cell.lblTitle.text = document.title
//		cell.textLabel?.text = document.title
	
		return cell
	}
	
	
	func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 20
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if(segue.identifier == "detailSegue")
		{
			let vc = segue.destinationViewController as! ADMDetailViewController
			let indexPath = self.tvResults.indexPathForCell(sender as! UITableViewCell)
			let doc: ADMDocument! = self.results[indexPath!.row]//self.manager.query.results[indexPath!.row]
			if(doc != nil)
			{
				vc.doc = doc as ADMDocument
			}
		}
	}
	
}