//
//  NavigationController.swift
//  RazorPortal
//
//  Created by Chris Drewry on 4/2/15.
//  Copyright (c) 2015 Chris Drewry. All rights reserved.
//

import Foundation
import UIKit

class NavigationController: UINavigationController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //totally not cardinal, should probably be fixed
        var cardinal = UIColor(red: 189.0/255.0, green: 32.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        
        //color of bar
        self.navigationBar.barTintColor = cardinal
        //color of buttons
        self.navigationBar.tintColor = UIColor.whiteColor()
        //color of titles
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}