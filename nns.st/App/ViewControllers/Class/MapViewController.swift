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
    
    private var locationManager: CLLocationManager? = nil
    private var resultSearchController:UISearchController? = nil
    private var bottomSheet: BottomSheetViewController!
    private var annotation: MKPointAnnotation = MKPointAnnotation()
    private var isSet: Bool = false
    
    private let delta: Double = 0.02
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.transparentNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addBottomSheetView()
        bottomSheet.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initLocationManager()
        self.initMap()
        self.updateMap(coordinate: mapview.userLocation.coordinate, isDropPin: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension MapViewController {
    
    func addBottomSheetView() {
        bottomSheet = BottomSheetViewController.instantiateViewController()
        
        self.addChildViewController(bottomSheet)
        self.view.addSubview(bottomSheet.view)
        
        bottomSheet.didMove(toParentViewController: self)
        bottomSheet.view.frame.origin = CGPoint(x: 0.0, y: self.view.frame.maxY)
        bottomSheet.mapview = mapview
        bottomSheet.tableView.delegate = self
    }
    
    func initLocationManager() {
        locationManager = CLLocationManager()
        locationManager!.delegate = self
    }
    
    func initMap() {
        mapview.mapType = MKMapType.standard
        mapview.userTrackingMode = MKUserTrackingMode.follow
    }
    
    func updateMap(coordinate: CLLocationCoordinate2D, isDropPin: Bool) {
        let span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        var center: CLLocationCoordinate2D = coordinate
        center.latitude -= 0.005
        let region = MKCoordinateRegion(center: center, span: span)
        mapview.region = region
        mapview.setRegion(region, animated: true)
        
        if isDropPin {
            mapview.removeAnnotation(annotation)
            annotation.coordinate = coordinate
            mapview.addAnnotation(annotation)
        }
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
        if mapview.userLocation.location != nil && !isSet {
            self.updateMap(coordinate: mapview.userLocation.coordinate, isDropPin: false)
            isSet = true
        }
    }
    
}


extension MapViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: SearchResultCell = tableView.cellForRow(at: indexPath) as! SearchResultCell
        
        self.updateMap(coordinate: cell.placemark.coordinate, isDropPin: true)
        bottomSheet.searchBar.text = cell.name.text
        bottomSheet.searchBar.resignFirstResponder()
    }
    
}


extension MapViewController: BottomSheetDelegate {
    
    func bottomSheet(_ bottomSheet: BottomSheetViewController, didCanceled items: [MKMapItem]) {
        
    }
    
    func bottomSheet(_ bottomSheet: BottomSheetViewController, SearchButtonClicked items: [MKMapItem]) {
        if bottomSheet.searchBar.text == "" {
            mapview.removeAnnotation(annotation)
            self.updateMap(coordinate: mapview.userLocation.coordinate, isDropPin: false)
            bottomSheet.searchBar.resignFirstResponder()
            return
        }
        
        if let item = items.first {
            self.updateMap(coordinate: item.placemark.coordinate, isDropPin: true)
            bottomSheet.searchBar.text = item.name
        }
        bottomSheet.searchBar.resignFirstResponder()
    }
    
}
