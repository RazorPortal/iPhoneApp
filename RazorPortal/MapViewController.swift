//
//  MapViewController.swift
//  RazorPortal
//
//  Created by Chris Drewry on 3/12/15.
//  Copyright (c) 2015 Chris Drewry. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var myMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set location to UARK campus
        let location = CLLocationCoordinate2D(latitude: 36.0687, longitude: -94.1760)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        myMap.setRegion(region, animated: true)
        
        //Drops example pins
        dropPin("Bell Engineering Center", subtitle: "BELL", lat: 36.067044, long: -94.171396)
        dropPin("JB Hunt Center for Academic Excellence", subtitle: "JBHT", lat: 36.065958, long: -94.173698)
        dropPin("Nanoscale Material Science and Engineering Building", subtitle: "NANO", lat: 36.066017, long: -94.169347)
        dropPin("Science and Engineering", subtitle: "SCEN", lat: 36.066999, long: -94.172636)
        dropPin("Arkansas Union", subtitle: "UNIN", lat: 36.068620, long: -94.175827)
        dropPin("Vol Walker Hall", subtitle: "VOLW", lat: 36.068664, long: -94.172721)
        dropPin("Mullins Library", subtitle: "MULL", lat: 36.068725, long: -94.173751)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //creates a new pin
    func dropPin(title: String, subtitle: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        let annotation = MKPointAnnotation()
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.setCoordinate(location)
        annotation.title = title
        annotation.subtitle = subtitle
        myMap.addAnnotation(annotation)
    }
    
    var data: NSArray = []
    
    //downloads user classes to an array
    func getUserClasses() {
        //database info
        let url : NSURL = NSURL(string: "http://uaf59189.ddns.uark.edu/Login.php")!
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        //request.HTTPBody = data.dataUsingEncoding(NSUTF8StringEncoding);
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response, data, error) in
            var output = NSString(data: data, encoding: NSUTF8StringEncoding)
            //var array = self.JSONParseArray(output)
        }
    }
}