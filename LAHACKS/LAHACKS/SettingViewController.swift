//
//  SettingViewController.swift
//  LAHACKS
//
//  Created by Angela Chen on 3/30/19.
//  Copyright © 2019 Angela Chen. All rights reserved.
//

import UIKit
//import CoreLocation
import MapKit

//class customPin: NSObject, MKAnnotation {
//    var coordinate: CLLocationCoordinate2D
//    var title: String?
//    var subtitle: String?
//
//    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D) {
//        self.title = pinTitle
//        self.subtitle = pinSubTitle
//        self.coordinate = location
//    }
//}

class SettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var theTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func finishEditing(_ sender: UIButton) {
        picker.isHidden = true
        mapView.isHidden = false
    }
    
    @IBAction func getLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    
    @IBAction func showAlert(_ sender: Any) {
        let alertController = UIAlertController(title: "Confirmation", message: "Your path is set, today's green is ready!", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    // add the OK action to the alert controller

    var pickerData = [String](arrayLiteral:"UCLA Bear", "UCLA Reckord Armory", "UCLA Royce Hall", "UCLA Powell Lib.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.isHidden = true
        self.picker.delegate = self
        self.picker.dataSource = self
        theTextField.inputView = picker
        
//        let action = UIAlertAction(title: "Confirmation",
//                                   style: .default,
//                                   handler: {
//                                    action in
//                                    self.switchViewController()
//        })
//
//        alert.addAction(action)

//        present(alert, animated: true, completion: nil)

        // bear: 34.0710, -118.445
        // ra: 34.0728, -118.4422
        // rh: 34.0728, -118.4422
        // powell: 34.0716, -118.4422
        
        // Do any additional setup after loading the view.
    }
    
    public func DispatchAfter(after: Double, handler:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            handler()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        
        if(row == 0) {
            location = CLLocationCoordinate2D(latitude: 34.0710, longitude: -118.445)
        } else if(row == 1) {
            location = CLLocationCoordinate2D(latitude: 34.0728, longitude: -118.4422)
        } else if(row == 2) {
            location = CLLocationCoordinate2D(latitude: 34.0728, longitude: -118.4422)
        } else {
            location = CLLocationCoordinate2D(latitude: 34.0716, longitude: -118.4422)
        }
        
        annotation.coordinate = location
        showCircle(coordinate: annotation.coordinate, radius: 100000, mapView: mapView)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        self.mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        
        theTextField.text = pickerData[row]
        return pickerData[row]
    }
    
//    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        theTextField.text = pickerData[row]
//        return pickerData[row]
//    }
    
//    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        theTextField.text = pickerData[row]
//    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
    func showCircle(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, mapView: MKMapView) {
        let circle = MKCircle(center: coordinate, radius: radius)
        mapView.addOverlay(circle)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
