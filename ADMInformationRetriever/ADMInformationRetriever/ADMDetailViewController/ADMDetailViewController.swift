//
//  ADMDetailViewController.swift
//  ADMInformationRetriever
//
//  Created by Frank Schmitt on 07.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMDetailViewController: UITableViewController {

//	weak var tvMain: UITextView!
	var doc: ADMDocument!
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
    override func viewDidLoad()
	{
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		self.navigationController?.setNavigationBarHidden(false, animated: true)
		
//		if (self.tvMain != nil)
//		{
//			self.tvMain.text = self.doc.abstract
//		}
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
		var cell:UITableViewCell
		if(indexPath.row == 5)
		{
			cell = tableView.dequeueReusableCellWithIdentifier("UITableViewDetailAbstractCell")! as! ADMDetailAbstractTableViewCell
		}
		else if(indexPath.row == 4)
		{
			cell = tableView.dequeueReusableCellWithIdentifier("UITableViewDetailPMIDCell")! as! ADMDetailPMIDTableViewCell
//			cell = tableView.dequeueReusableCellWithIdentifier("UITableViewDetailCell")! as! ADMDetailTableViewCell

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
//			let s = ",".join(doc.authors.map{String($0)})

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
			(cell as! ADMDetailPMIDTableViewCell).tvContent!.text = self.getURLForPMID(doc.pmid).absoluteString
		}
		else if(indexPath.row == 5)
		{
			(cell as! ADMDetailAbstractTableViewCell).lblTitle!.text = "Abstract"
			(cell as! ADMDetailAbstractTableViewCell).tvContent!.text = doc.abstract
		}
		
//		cell.lblTitle.backgroundColor = UIColor.orangeColor()
//		cell.tvContent.backgroundColor = UIColor.greenColor()
	
//		cell.textLabel?.text = document.title
	
		return cell
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if(segue.identifier == "pmidWebSegue")
		{
			let vc = segue.destinationViewController as! ADMDetailPMIDViewController
			if(doc != nil)
			{
//				let request: NSURLRequest = NSURLRequest(URL: self.getURLForPMID(doc.pmid))
//				vc.wvMain.loadRequest(request)
				vc.url = self.getURLForPMID(doc.pmid)
				vc.title = doc.title
			}
		}
	}
	
	func getURLForPMID(pmid: String) -> NSURL
	{
		let url = NSURL(string: "http://www.ncbi.nlm.nih.gov/pubmed/?term="+doc.pmid)
		return url!
//		return NSURL(fileURLWithPath: "http://www.ncbi.nlm.nih.gov/pubmed/?term="+doc.pmid)
//		return NSURL(string: "http://www.ncbi.nlm.nih.gov/pubmed/?term="+doc.pmid)
		
	}
}
