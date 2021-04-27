//
//  MapViewController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 19.04.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
       var myLocationManager: CLLocationManager!
       var pilzAnnotation: MeinePilzAnnotation!
       var lastCoordinate: CLLocationCoordinate2D!
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
             myLocationManager = CLLocationManager()
             if myLocationManager.responds(to: #selector(myLocationManager.requestWhenInUseAuthorization)){
                 myLocationManager.requestWhenInUseAuthorization()
             }
             let region = MKCoordinateRegion(center: pilzAnnotation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
             mapView.delegate = self
             mapView.showsUserLocation = true
             mapView.addAnnotation(pilzAnnotation)
             mapView.setRegion(region, animated: true)
    }
    @IBAction func btnZurueckDown(_ sender: UIBarButtonItem) {
           self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnHierDown(_ sender: UIBarButtonItem) {
        let userLocation = mapView.userLocation
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(region, animated: true)
    }
    @IBAction func btnTypDown(_ sender: UIBarButtonItem) {
        if mapView.mapType == .standard{
                 mapView.mapType = .satellite
             }else{
                 mapView.mapType = .standard
             }
    }
    @IBAction func btnNavigationDown(_ sender: UIBarButtonItem) {
        let userPlacemark = MKPlacemark(coordinate: mapView.userLocation.coordinate)
         let pilzPlacemark = MKPlacemark(coordinate: pilzAnnotation.coordinate)
         let routeRequest = MKDirections.Request()
         routeRequest.destination = MKMapItem(placemark: pilzPlacemark)
         routeRequest.source = MKMapItem(placemark: userPlacemark)
         let direction = MKDirections(request: routeRequest)
         direction.calculate(completionHandler: {(response:
             MKDirections.Response?, error: Error?) in
             if (error != nil){
                 let alertController = UIAlertController(title: "MeinePilze", message: "Fehler in der Navigationsberechnung", preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                 alertController.addAction(okAction)
                 self.present(alertController, animated: true, completion: nil)
             }else{
                 self.showRoute(response: response!)
             }
         })
    }
    @IBAction func btnTrackingDown(_ sender: UIBarButtonItem) {
        if(sender.title?.contains("Track"))!{
             sender.title = "Stop"
             mapView.removeOverlays(mapView.overlays)
             lastCoordinate = mapView.userLocation.coordinate
             let region = MKCoordinateRegion(center: lastCoordinate, latitudinalMeters: 200, longitudinalMeters: 200)
             mapView.setRegion(region, animated: true)
             myLocationManager.delegate = self
             myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
             myLocationManager.distanceFilter = 5
             myLocationManager.startUpdatingLocation()
         }else{
             let region = MKCoordinateRegion(center: pilzAnnotation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
             mapView.setRegion(region, animated: true)
             myLocationManager.stopUpdatingLocation()
             sender.title = "Tracking"
         }
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
         let renderer = MKPolylineRenderer(overlay: overlay)
         renderer.strokeColor = UIColor.blue
         renderer.lineWidth = 3.0
         return renderer
     }
     
     func showRoute(response: MKDirections.Response){
         self.mapView.removeOverlays(self.mapView.overlays)
         let route = response.routes[0]
         self.mapView.addOverlay(route.polyline, level: .aboveLabels)
         
         var centerLatitude = mapView.userLocation.coordinate.latitude - pilzAnnotation.coordinate.latitude
         centerLatitude = mapView.userLocation.coordinate.latitude - centerLatitude / 2
         var centerLongitude = mapView.userLocation.coordinate.longitude - pilzAnnotation.coordinate.longitude
         centerLongitude = mapView.userLocation.coordinate.longitude - centerLongitude / 2
         let centerCoordinate = CLLocationCoordinate2D(latitude: centerLatitude, longitude: centerLongitude)
         let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: route.distance, longitudinalMeters: route.distance)
         mapView.setRegion(region, animated: true)
     }
     
     func showRoute(_ zielCoordinate: CLLocationCoordinate2D){
         let coords: [CLLocationCoordinate2D] = [lastCoordinate, zielCoordinate]
         let polyline = MKPolyline(coordinates: coords, count: 2)
         mapView.addOverlay(polyline)
     }
     
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         showRoute(locations.last!.coordinate)
         lastCoordinate = (locations.last!.coordinate)
     }
}
