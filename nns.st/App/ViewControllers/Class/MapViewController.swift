//
//  MapViewController.swift
//  nns.st
//
//  Created by SHOHE on 2018/08/18.
//  Copyright © 2018 OhtaniShohe. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapview: MKMapView!
    
    var locationManager: CLLocationManager? = nil
    var resultSearchController:UISearchController? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addBottomSheetView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLocationManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension MapViewController {
    
    func addBottomSheetView() {
        let viewController = BottomSheetViewController.instantiateViewController()
        viewController.view.layer.cornerRadius = 10
        
        self.addChildViewController(viewController)
        self.view.addSubview(viewController.view)
        
        viewController.didMove(toParentViewController: self)
        viewController.view.frame.origin = CGPoint(x: 0.0, y: self.view.frame.maxY)
        viewController.mapview = mapview
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
    }
    
    func initMap() {
        var region:MKCoordinateRegion = mapview.region
        region.center = mapview.userLocation.coordinate
        
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        
        mapview.setRegion(region,animated:true)
        
        mapview.mapType = MKMapType.standard
        
        mapview.userTrackingMode = MKUserTrackingMode.follow
        mapview.userTrackingMode = MKUserTrackingMode.followWithHeading
    }
    

    
}


extension MapViewController: MKMapViewDelegate {
    
}



extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        default:
            break
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapview.region = region
        }
        
    }
    
}
