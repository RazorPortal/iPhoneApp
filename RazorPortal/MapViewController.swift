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
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var myMap: MKMapView!
    
    //globals
    var data: NSArray = []
    let locationManager = CLLocationManager()
    var account = "apptest"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //location services check
        if (CLLocationManager.locationServicesEnabled())
        {
            //asks user for tracking permission
            self.locationManager.requestWhenInUseAuthorization()
            
            //centers location to uark campus
            let location = CLLocationCoordinate2D(latitude: 36.0687, longitude: -94.1760)
            let span = MKCoordinateSpanMake(0.04, 0.04)
            let region = MKCoordinateRegion(center: location, span: span)
            myMap.setRegion(region, animated: true)
            
            //sets location info
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            self.myMap.mapType = MKMapType.Standard
            self.myMap.showsUserLocation = true
        }
        
        //talk to database
        //dropHardCodedPins()
        getuserrecords()
    }
    
    //location manager method
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var locValue: CLLocationCoordinate2D = locationManager.location.coordinate
        let cent = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        let region = MKCoordinateRegion(center: cent, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.myMap.setRegion(region, animated: true)
        var currentLoc = CLLocation()
        var locLat = currentLoc.coordinate.latitude
        var locLong = currentLoc.coordinate.longitude
    }
    
    //only call for demonstrations where an account isnt already setup
    func dropHardCodedPins() {
        //sets centered location to UARK campus
        //let location = CLLocationCoordinate2D(latitude: 36.0687, longitude: -94.1760)
        //let span = MKCoordinateSpanMake(0.04, 0.04)
        //let region = MKCoordinateRegion(center: location, span: span)
        //myMap.setRegion(region, animated: true)
        
        dropPin("Bell Engineering Center", subtitle: "BELL", lat: 36.067044, long: -94.171396)
        dropPin("JB Hunt Center for Academic Excellence", subtitle: "JBHT", lat: 36.065958, long: -94.173698)
        dropPin("Nanoscale Material Science and Engineering Building", subtitle: "NANO", lat: 36.066017, long: -94.169347)
        dropPin("Science and Engineering", subtitle: "SCEN", lat: 36.066999, long: -94.172636)
        dropPin("Arkansas Union", subtitle: "UNIN", lat: 36.068620, long: -94.175827)
        dropPin("Vol Walker Hall", subtitle: "VOLW", lat: 36.068664, long: -94.172721)
        dropPin("Mullins Library", subtitle: "MULL", lat: 36.068725, long: -94.173751)
        dropPin("Mechanical Engineering", subtitle: "MEEG", lat: 36.066359, long: -94.172850)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //creates a new pin
    func dropPin(title: String, subtitle: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        let annotation = MKPointAnnotation()
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subtitle
        myMap.addAnnotation(annotation)
    }
    
    func dataOfJson(url: String) -> NSArray {
        var data = NSData(contentsOfURL: NSURL(string: url)!)
        return (NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray)
    }
    
    //downloads user classes to an array
    func getuserrecords() {
        /* I know this looks like a code monkey vomited syntax everywhere, but here's the big idea:
        NSString is basically a str or char[]
        arr is the raw JSON fetched string
        dataSrc is a pointer to arr[head] */
        
        let url = NSURL(string: "http://uaf59189.ddns.uark.edu/service.php")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var d = NSString(data: data, encoding: NSUTF8StringEncoding)
            var arr = d!.componentsSeparatedByString("<")
            var dataSrc:NSString = arr[0]as! NSString
            if let data = NSJSONSerialization.JSONObjectWithData(dataSrc.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray {
                for dd in data {
                    var username : String = dd["username"]! as! String
                    var classname : String = dd["classname"]! as! String
                    var days : String = dd["days"]!as! String
                    var time : String = dd["time"]! as! String
                    var building : String = dd["building"]! as! String
                    var room : String = dd["room"]! as! String
                    var classcode : String = dd["classcode"]! as! String
                    
                    if (username == self.account) {
                        self.getBuildingData(building)
                    }
                }
            }
        }
        
        task.resume()
    }
    
    //handles building data fetching
    func getBuildingData(building: String)
    {
        let url = NSURL(string: "http://uaf59189.ddns.uark.edu/serviceBuildings.php")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var d = NSString(data: data, encoding: NSUTF8StringEncoding)
            var arr = d!.componentsSeparatedByString("<")
            var dataSrc:NSString = arr[0]as! NSString
            if let data = NSJSONSerialization.JSONObjectWithData(dataSrc.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSArray {
                for dd in data {
                    var bCode : String = dd["Building_Code"]! as! String
                    var bName : String = dd["Building_Name"]! as! String
                    var bLat : String = dd["Latitude"]!as! String
                    var bLong : String = dd["Longitude"]! as! String
                    
                    if (building == bCode) {
                        let dubLat = (bLat as NSString).doubleValue
                        let dubLong = (bLong as NSString).doubleValue
                        self.dropPin(bName, subtitle: bCode, lat: dubLat, long: dubLong)
                    }
                }
            }
        }
        
        task.resume()
    }
}