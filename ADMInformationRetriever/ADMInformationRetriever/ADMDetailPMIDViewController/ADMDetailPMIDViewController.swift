//
//  ADMDetailPMIDViewController.swift
//  ADMInformationRetriever
//
//  Created by Frank Schmitt on 20.11.15.
//  Copyright © 2015 sovanta AG. All rights reserved.
//

import UIKit

class ADMDetailPMIDViewController: UIViewController, UIWebViewDelegate {

	var url: NSURL!
	@IBOutlet weak var wvMain: UIWebView!
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		let request: NSURLRequest = NSURLRequest(URL: self.url)
		self.wvMain.loadRequest(request)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
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
	
	//	MARK: - UIWebViewDelegate implementations
	func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
		print(error)
	}
	
	func webViewDidStartLoad(webView: UIWebView) {
		
	}
	
	func webViewDidFinishLoad(webView: UIWebView) {
		
	}


}
