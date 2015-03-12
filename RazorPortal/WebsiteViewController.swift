//
//  WebsiteViewController.swift
//  RazorPortal
//
//  Created by Chris Drewry on 3/12/15.
//  Copyright (c) 2015 Chris Drewry. All rights reserved.
//

import Foundation
import UIKit

class WebsiteViewController: UIViewController {
    @IBOutlet weak var myWeb: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "http://csce.uark.edu/~cxfreema/RazorPortal/Login.html"
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        myWeb.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}