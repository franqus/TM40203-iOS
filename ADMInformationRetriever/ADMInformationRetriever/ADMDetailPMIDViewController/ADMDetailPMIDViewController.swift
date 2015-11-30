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
    }
	
	//	MARK: - UIWebViewDelegate implementations
	func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
		print(error)
	}

}
