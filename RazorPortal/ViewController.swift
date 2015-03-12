//
//  ViewController.swift
//  RazorPortal
//
//  Created by Chris Drewry on 3/12/15.
//  Copyright (c) 2015 Chris Drewry. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    //necessary outlets
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var myWeb: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //======================Map=========================//
        //set location to UARK campus
        let location = CLLocationCoordinate2D(latitude: 36.0687, longitude: 94.1760)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        //myMap.setRegion(region, animated: true)
        
        //makes pin annotation to ID campus
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "University of Arkansas"
        annotation.subtitle = "Fayetteville"
        //myMap.addAnnotation(annotation)
        
        
        //======================Website=========================//
        let url = "http://csce.uark.edu/~cxfreema/RazorPortal/Login.html"
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        //myWeb.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

