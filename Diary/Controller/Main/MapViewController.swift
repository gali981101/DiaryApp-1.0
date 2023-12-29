//
//  MapViewController.swift
//  Diary
//
//  Created by Terry Jason on 2023/12/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var diary = Diary()
    
}

// MARK: - Life Cycle

extension MapViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(diary.location) { placemarks, error in
            guard error == nil else { return }
            guard let location = placemarks?.first?.location else { return }
            
            let annotation = MKPointAnnotation()
            
            annotation.title = self.diary.title
            annotation.subtitle = self.diary.date
            
            annotation.coordinate = location.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Diary_Marker"
        
        if annotation.isKind(of: MKUserLocation.self) { return nil }
        
        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView?.glyphImage = UIImage(systemName: "pencil.slash")
        annotationView?.markerTintColor = .systemMint
        
        return annotationView
    }
    
}
