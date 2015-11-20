//
//  ADMDetailViewController.swift
//  ADMInformationRetriever
//
//  Created by Frank Schmitt on 07.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMDetailViewController: UITableViewController {

	@IBOutlet weak var tvMain: UITextView!
	@IBOutlet var doc: ADMDocument!
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		self.navigationController?.setNavigationBarHidden(false, animated: true)
		
		if (self.tvMain != nil)
		{
			self.tvMain.text = self.doc.abstract
		}
	}

    override func didReceiveMemoryWarning()
	{
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return 6
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		if(indexPath.row == 5)
		{
			return 300
		}
		else if(indexPath.row == 4)
		{
			return 60
		}
		else
		{
			return 80
		}
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		var cell:ADMDetailTableViewCell
		if(indexPath.row == 5)
		{
			cell = tableView.dequeueReusableCellWithIdentifier("UITableViewDetailAbstractCell")! as! ADMDetailAbstractTableViewCell
		}
		else if(indexPath.row == 4)
		{
			cell = tableView.dequeueReusableCellWithIdentifier("UITableViewDetailPMIDCell")! as! ADMDetailPMIDTableViewCell
		}
		else
		{
			cell = tableView.dequeueReusableCellWithIdentifier("UITableViewDetailCell")! as! ADMDetailTableViewCell
		}
		
		if(indexPath.row == 0)
		{
			cell.lblTitle!.text = "Title"
			cell.tvContent!.text = doc.title
		}
		else if(indexPath.row == 1)
		{
			cell.lblTitle!.text = "Journal"
			cell.tvContent!.text = doc.journal
		}
		else if(indexPath.row == 2)
		{
//			cell.textLabel!.text = doc.authors
		}
		else if(indexPath.row == 3)
		{
			cell.lblTitle!.text = "Institutions"
			cell.tvContent!.text = doc.institutions
		}
		else if(indexPath.row == 4)
		{
			cell.lblTitle!.text = "PMID"
			cell.tvContent!.text = self.getURLForPMID(doc.pmid).absoluteString
		}
		else if(indexPath.row == 5)
		{
			cell.lblTitle!.text = "Abstract"
			cell.tvContent!.text = doc.abstract
		}
	
//		cell.textLabel?.text = document.title
	
		return cell
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if(segue.identifier == "pmidWebSegue")
		{
			let vc = segue.destinationViewController as! ADMDetailPMIDViewController
			if(doc != nil)
			{
//				vc.url = self.getURLForPMID(doc.pmid)
			}
		}
	}
	
	func getURLForPMID(pmid: String) -> NSURL
	{
		return NSURL(fileURLWithPath: "http://pmidonline.com/?id="+doc.pmid)
	}
}
