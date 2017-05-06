//
//  MapViewController.swift
//  MountainMan
//
//  Created by Jake Mnich on 4/26/17.
//  Copyright © 2017 Jake Mnich. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var directionButton: UIBarButtonItem!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var annotation = MKPointAnnotation()
    var selectedAnnotation: MKPointAnnotation!
    var myRoute: MKRoute!
    
    let mountainArray = [
        ["title": "Stowe", "subtitle": "Stowe, VT", "latitude": 44.5297, "longitude": -72.7793,],
        ["title": "Jay Peak", "subtitle": "Jay, VT", "latitude": 44.9649, "longitude": -72.4602],
        ["title": "Killington", "subtitle": "Killington, VT", "latitude": 43.6776, "longitude": -72.7798],
        ["title": "Okemo", "subtitle": "Ludlow, VT", "latitude": 43.4016, "longitude": -72.7170],
        ["title": "Sugarbush", "subtitle": "Warren, VT", "latitude": 44.1361, "longitude": -72.8944],
        ["title": "Bretton Woods", "subtitle": "Bretton Woods, NH", "latitude": 44.2594, "longitude": -71.4597],
        ["title": "Smugglers' Notch", "subtitle": "Jeffersonville, VT", "latitude": 44.5885, "longitude": -72.7900],
        ["title": "Loon", "subtitle": "Lincoln, NH", "latitude": 44.0360, "longitude": -71.6214],
        ["title": "Mad River Glen", "subtitle": "Waitsfield, VT", "latitude": 44.2025, "longitude": -72.9175],
        ["title": "Mount Snow", "subtitle": "Dover, VT", "latitude": 42.9602, "longitude": -72.9204],
        ["title": "Sugarloaf", "subtitle": "Carrabassett Valley, ME", "latitude": 45.0540, "longitude": -70.3082],
        ["title": "Stratton", "subtitle": "Stratton, VT", "latitude": 43.0906, "longitude": -72.9278],
        ["title": "Sunday River", "subtitle": "Newry, ME", "latitude": 44.4694, "longitude": -70.8611],
        ["title": "Cannon", "subtitle": "Franconia, NH", "latitude": 44.1565, "longitude": -71.6984],
        ["title": "Wildcat", "subtitle": "Pinkham Notch, NH", "latitude": 44.2590, "longitude": -71.2015],
        ["title": "Waterville Valley", "subtitle": "Waterville Valley, NH", "latitude": 43.9647, "longitude": -71.5262],
        ["title": "Burke", "subtitle": "East Burke, VT", "latitude": 44.5712, "longitude": -71.8923],
        ["title": "Pico", "subtitle": "Mendon, VT", "latitude": 43.6514, "longitude": -72.8410],
        ["title": "Attitash", "subtitle": "Bartlett, NH", "latitude": 44.0828, "longitude": -71.2294],
        ["title": "Saddleback", "subtitle": "Rangeley, ME", "latitude": 44.9367, "longitude": -70.5031],
        ["title": "Magic Mountain", "subtitle": "Londonderry, VT", "latitude": 43.2017, "longitude": -72.7726],
        ["title": "Sunapee", "subtitle": "Newbury, NH", "latitude": 43.3136, "longitude": -72.0742],
        ["title": "Gunstock", "subtitle": "Gilford, NH", "latitude": 43.5354, "longitude": -71.3701],
        ["title": "Bromley", "subtitle": "Peru, VT", "latitude": 43.2279, "longitude": -72.9387],
        ["title": "Shawnee Peak", "subtitle": "Bridgton, ME", "latitude": 44.0590, "longitude": -70.8155],
        ["title": "Cranmore", "subtitle": "North Conway, NH", "latitude": 44.0569, "longitude": -71.0996],
        ["title": "Jiminy Peak", "subtitle": "Hancock, MA", "latitude": 42.5560, "longitude": -73.2909],
        ["title": "Ragged Mountain", "subtitle": "Danbury, NH", "latitude": 43.4722, "longitude": -71.8456],
        ["title": "Bolton Valley", "subtitle": "Richmond, VT", "latitude": 44.4210, "longitude": -72.8503],
        ["title": "Berkshire East", "subtitle": "Charlemont, MA", "latitude": 42.6227, "longitude": -72.8784],
        ["title": "Butternut", "subtitle": "Great Barrington, MA", "latitude": 42.1837, "longitude": -73.3202],
        ["title": "Crotched Mountain", "subtitle": "Bennington, NH", "latitude": 43.0120, "longitude": -71.8789],
        ["title": "Pat's Peak", "subtitle": "Henniker, NH", "latitude": 43.1594, "longitude": -71.7960],
        ["title": "Suicide Six", "subtitle": "South Pomfret, VT", "latitude": 43.6651, "longitude": -72.5433],
        ["title": "Ski Sundown", "subtitle": "New Hartford, CT", "latitude": 41.8847, "longitude": -72.9467],
        ["title": "Blandford", "subtitle": "Blandford, MA", "latitude": 42.1944, "longitude": -72.9117],
        ["title": "Mount Abram", "subtitle": "Greenwood, ME", "latitude": 44.3791, "longitude": -70.7069],
        ["title": "Black Mountain", "subtitle": "Rumford, ME", "latitude": 44.5770, "longitude": -70.6133],
        ["title": "Big Rock", "subtitle": "Mars Hill, ME", "latitude": 46.5224, "longitude": -67.8289],
        ["title": "Bousquet", "subtitle": "Pittsfield, MA", "latitude": 42.4180, "longitude": -73.2772]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
       
        
        let randomMountain = Int(arc4random_uniform(UInt32(mountainArray.count - 1)))
        let mountain = mountainArray[randomMountain]
            annotation = MKPointAnnotation()
            annotation.title = mountain["title"] as? String
            annotation.subtitle = mountain["subtitle"] as? String
            annotation.coordinate = CLLocationCoordinate2D(latitude: mountain["latitude"] as! Double, longitude: mountain["longitude"] as! Double)
        
            mapView.addAnnotation(annotation)
    }
    
    @IBAction func directionsButtonPressed(_ sender: UIBarButtonItem) {
        mapView.delegate = self
        
        let source = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let destination = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        let sourcePlacemark = MKPlacemark(coordinate: source, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destination, addressDictionary: nil)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.requestsAlternateRoutes = false
        directionRequest.transportType = .automobile
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            
            if error == nil {
                self.myRoute = response!.routes[0] as MKRoute
                self.mapView.add(self.myRoute.polyline)
            }
            
        })
       
        
    }
    
   
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
        myLineRenderer.strokeColor = UIColor.blue
        myLineRenderer.lineWidth = 3
        return myLineRenderer
    }
    
    @IBAction func unwindToMapView(segue: UIStoryboardSegue) {
        
    }
    
    
    
    
}



extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations.last
        
        let currentLat = "\(currentLocation.coordinate.latitude)"
        let currentLong = "\(currentLocation.coordinate.longitude)"
        
        print("coordinates are: \(currentLat), \(currentLong)")
        
        locationManager.stopUpdatingLocation()
        
    }
    
    
}

