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
	enum ADMSearchMode {
		case ADMSearchModeSimple
		case ADMSearchModeAdvanced
	}
	
	@IBOutlet weak var tfSearch: UITextField!
	@IBOutlet weak var tvResults: UITableView!
	@IBOutlet weak var viewTopContainer: UIView!
	@IBOutlet weak var scSource: UISegmentedControl!
	@IBOutlet weak var btnGo: UIButton!
	@IBOutlet weak var aiRequest: UIActivityIndicatorView!
	
	@IBOutlet weak var tfAuthor: UITextField!
	@IBOutlet weak var constrAuthor: NSLayoutConstraint!
	
	@IBOutlet weak var tfJournal: UITextField!
	@IBOutlet weak var constrJournal: NSLayoutConstraint!
	
	@IBOutlet weak var tfInstitution: UITextField!
	@IBOutlet weak var constrInstitutions: NSLayoutConstraint!
	
	@IBOutlet weak var tfAbstract: UITextField!
	@IBOutlet weak var constrAbstract: NSLayoutConstraint!
	
	@IBOutlet weak var switchAdvanced: UISwitch!
	
	@IBOutlet weak var containerHeight: NSLayoutConstraint!
	
	var searchMode: ADMSearchMode = ADMSearchMode.ADMSearchModeSimple
	var manager: ADMInformationManager!
    let documentsPerSection: String = "1000"
	var results: Array<ADMDocument> = [ADMDocument]()
	var totalResults: Int = 0
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		manager = ADMInformationManager(mockFilename: "mockdata")
		
		self.manager.curServer = self.manager.servers[self.scSource.selectedSegmentIndex]
		self.btnGo.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled)
		self.tfSearch.becomeFirstResponder()
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
	
	func textFieldShouldReturn(textField: UITextField) -> Bool
	{
		textField.resignFirstResponder()
		self.btnSearch_tapped(self.btnGo)
		return true
	}
	
	@IBAction func btnSearch_tapped(sender: AnyObject)
	{
		if((self.tfSearch.text == nil || self.tfSearch.text == "") && self.searchMode == ADMSearchMode.ADMSearchModeSimple)
		{
			return
		}
		
		var paramDict: NSDictionary
		if(self.searchMode == ADMSearchMode.ADMSearchModeAdvanced)
		{
			paramDict = ["length":self.documentsPerSection,
				"startIndex":"0",
				"search":["journal":self.tfJournal.text!,
					"authors":self.tfAuthor.text!,
					"title":self.tfSearch.text!,
					"institutions":self.tfInstitution.text!,
					"abstract":self.tfAbstract.text!]]
		}
		else
		{
			paramDict = ["length":self.documentsPerSection,
				"startIndex":"0",
				"search":["journal":self.tfSearch.text!,
					"authors":self.tfSearch.text!,
					"title":self.tfSearch.text!,
					"institutions":self.tfSearch.text!,
					"abstract":self.tfSearch.text!]]
		}
		
		let searchModeFlag = self.searchMode == ADMSearchMode.ADMSearchModeAdvanced ? true : false
		let query: ADMQuery = ADMQuery.init(params: paramDict, advancedSearch: searchModeFlag)
		
		self.aiRequest.startAnimating()
		self.btnGo.hidden = true
		self.manager.sendQuery(query, server: self.manager.curServer, index: 0, length: Int(self.documentsPerSection)!) { (response, totalResults, error) -> Void in
			
			if(error == nil)
			{
				self.results = response as! Array<ADMDocument>
				self.totalResults = totalResults
				
				dispatch_async(dispatch_get_main_queue())
				{
					self.aiRequest.stopAnimating()
					self.btnGo.hidden = false
					self.tvResults.reloadData()
				}
			}
			else
			{
				dispatch_async(dispatch_get_main_queue())
				{
						self.aiRequest.stopAnimating()
						self.btnGo.hidden = false
				}
				print("error=%@",error)
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
	}
	
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
		
		cell.lblRank.text = String(format: "%.3f", document.rank!)
		cell.lblTitle.text = document.title
	
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
			let doc: ADMDocument! = self.results[indexPath!.row]
			if(doc != nil)
			{
				vc.doc = doc as ADMDocument
			}
		}
	}
	
	@IBAction func toggleSearchMode(sender: UISwitch)
	{

		if(sender.on)
		{
			self.searchMode = ADMSearchMode.ADMSearchModeAdvanced
			self.containerHeight.constant += 140
			self.constrAuthor.constant += 35
			self.constrJournal.constant += 70
			self.constrInstitutions.constant += 105
			self.constrAbstract.constant += 140
			UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
				
				self.tfSearch.placeholder = "Title"
				self.tfAuthor.hidden = false
				self.tfJournal.hidden = false
				self.tfInstitution.hidden = false
				self.tfAbstract.hidden = false
				
				self.viewTopContainer.layoutIfNeeded()
				}, completion: { finished in
			})
		}
		else
		{
			self.searchMode = ADMSearchMode.ADMSearchModeSimple
			self.containerHeight.constant -= 140
			self.constrAuthor.constant -= 35
			self.constrJournal.constant -= 70
			self.constrInstitutions.constant -= 105
			self.constrAbstract.constant -= 140
			
			UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
				
				self.tfSearch.placeholder = ""
				self.viewTopContainer.layoutIfNeeded()
				
				}, completion: { finished in
					self.tfAuthor.hidden = true
					self.tfJournal.hidden = true
					self.tfInstitution.hidden = true
					self.tfAbstract.hidden = true
			})
		}

	}
}