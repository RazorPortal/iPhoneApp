//
//  MapViewController.swift
//  RazorPortal
//
//  Created by Chris Drewry on 3/12/15.
//  Copyright (c) 2015 Chris Drewry. All rights reserved.
//
// IMPORTANT SHIT:
//      user: root
//      pass: tu3xooGh
//      when in doubt, var char[255]
//
//currently only pulls classes for apptest

import Foundation
import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var myMap: MKMapView!
    
    //globals
    var data: NSArray = []
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set location to UARK campus
        let location = CLLocationCoordinate2D(latitude: 36.0687, longitude: -94.1760)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        myMap.setRegion(region, animated: true)
        
        //show current user location
        locationManager.requestWhenInUseAuthorization()
        self.myMap.mapType = MKMapType.Standard
        self.myMap.showsUserLocation = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //talk to database
        getallrecords()
        
        
        
        //Drops example pins
        //dropPin("Bell Engineering Center", subtitle: "BELL", lat: 36.067044, long: -94.171396)
        //dropPin("JB Hunt Center for Academic Excellence", subtitle: "JBHT", lat: 36.065958, long: -94.173698)
        //dropPin("Nanoscale Material Science and Engineering Building", subtitle: "NANO", lat: 36.066017, long: -94.169347)
        //dropPin("Science and Engineering", subtitle: "SCEN", lat: 36.066999, long: -94.172636)
        //dropPin("Arkansas Union", subtitle: "UNIN", lat: 36.068620, long: -94.175827)
        //dropPin("Vol Walker Hall", subtitle: "VOLW", lat: 36.068664, long: -94.172721)
        //dropPin("Mullins Library", subtitle: "MULL", lat: 36.068725, long: -94.173751)
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
    
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        return (NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSArray)
    }
    
    //downloads user classes to an array
    func getallrecords(){
        let url = NSURL(string: "http://uaf59189.ddns.uark.edu/service.php")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var d = NSString(data: data, encoding: NSUTF8StringEncoding)
            var arr = d!.componentsSeparatedByString("<")
            // spliting the incoming string from "<" operator because before that operator is our required data and storing in array
            var dataweneed:NSString = arr[0] as NSString
            // arr[0] is the data before "<" operator and arr[1] is actually no use for us
            if let data = NSJSONSerialization.JSONObjectWithData(dataweneed.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray
            {
                for dd in data{
                    var username : String = dd["username"]! as String
                    var classname : String = dd["classname"]! as String
                    var days : String = dd["days"]! as String
                    var time : String = dd["time"]! as String
                    var building : String = dd["building"]! as String
                    var room : String = dd["room"]! as String
                    var classcode : String = dd["classcode"]! as String
                    
                    if (username == "apptest") {
                        self.dropPin(building, subtitle: " ", lat: 36.065958, long: -94.171396)
                    }
                }
            }
        }
        
        task.resume()
    }
}