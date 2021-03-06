//
//  ADMDetailViewController.swift
//  ADMInformationRetriever
//
//  Created by Frank Schmitt on 07.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMDetailViewController: UITableViewController {

	var doc: ADMDocument!
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		self.navigationController?.setNavigationBarHidden(false, animated: true)
	}
	
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
		var cell:UITableViewCell
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
			(cell as! ADMDetailTableViewCell).lblTitle!.text = "Title"
			(cell as! ADMDetailTableViewCell).tvContent!.text = doc.title
		}
		else if(indexPath.row == 1)
		{
			(cell as! ADMDetailTableViewCell).lblTitle!.text = "Journal"
			(cell as! ADMDetailTableViewCell).tvContent!.text = doc.journal
		}
		else if(indexPath.row == 2)
		{
			(cell as! ADMDetailTableViewCell).lblTitle!.text = "Authors"
			(cell as! ADMDetailTableViewCell).tvContent!.text = doc.authors.joinWithSeparator(",")//doc.authors.description
		}
		else if(indexPath.row == 3)
		{
			(cell as! ADMDetailTableViewCell).lblTitle!.text = "Institutions"
			(cell as! ADMDetailTableViewCell).tvContent!.text = doc.institutions
		}
		else if(indexPath.row == 4)
		{
			(cell as! ADMDetailPMIDTableViewCell).lblTitle!.text = "PMID"
			(cell as! ADMDetailPMIDTableViewCell).tvContent!.text = self.getURLForPMID(doc.pmid!).absoluteString
		}
		else if(indexPath.row == 5)
		{
			(cell as! ADMDetailAbstractTableViewCell).lblTitle!.text = "Abstract"
			(cell as! ADMDetailAbstractTableViewCell).tvContent!.text = doc.abstract
		}
	
		return cell
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if(segue.identifier == "pmidWebSegue")
		{
			let vc = segue.destinationViewController as! ADMDetailPMIDViewController
			if(doc != nil)
			{
				vc.url = self.getURLForPMID(doc.pmid!)
				vc.title = doc.title
			}
		}
	}
	
	func getURLForPMID(pmid: String) -> NSURL
	{
		let url = NSURL(string: "http://www.ncbi.nlm.nih.gov/pubmed/?term="+doc.pmid!)
		return url!
	}
}
