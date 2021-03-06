import UIKit
import MapKit
import CoreLocation
import AVFoundation
import AudioToolbox
import UserNotifications


class MapViewController: UIViewController, CLLocationManagerDelegate {
    
   
    
    @IBAction func cancelAlertButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Stop Alarm", message: "Are You Sure You Want To Stop Your Alarm?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: { _ in
            self.dismiss(animated: true, completion: nil)
        }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var distanceLabel: UILabel!

    var showingAlert = false
    
    let locationManager = CLLocationManager()
    
    var alarm: String?
    var distanceFrom: Double?
    
    var destination: CLLocation?
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let userLocation = locations.last else { return }
        
        //loop through all the alarms, and trigger one if needed
        
        for alarm in AlarmManager.shared.alarms {
            print(userLocation.distance(from: alarm.location))
            if userLocation.distance(from: alarm.location) < alarm.distance && !alarm.triggered {
                print(alarm.distance)
                alarm.triggered = true
                showNotification(for: alarm)
                showAlert(for: alarm)
                
            }
            
        }
        
        
        
//        let span = MKCoordinateSpanMake(0.01, 0.01)
//        
//        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude,         location.coordinate.longitude)
//        
//        let region = MKCoordinateRegionMake(myLocation, span)
//        
//        mapView.setRegion(region, animated: true)
//        
//        guard destination != nil else { return }
//     
        
 //      let distanceFromDestination = userLocation .distance(from: destination!)
        
 //      distanceLabel.text = String(format: "%.2f km", ceil(Double(distanceFromDestination/1000)*100)/100)
//
//        
//        if distanceFromDestination < Double(distanceFrom! * 1000) {
//            print("arrived")
//            showAlert()
//        }
//        
//        
//        self.mapView.showsUserLocation = true
        
    }
    
    var alertController:UIAlertController?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.setUserTrackingMode(.follow, animated: true)
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        mapView.delegate = self
        
        initNotificationSetupCheck()
        
        addAnnotations()
    }
    
    func addAnnotations() {
        for alarm in AlarmManager.shared.alarms {
            let annotation = MKPointAnnotation()
            annotation.coordinate = alarm.coordinates
            annotation.title = alarm.name
            annotation.subtitle = alarm.sound + " \(alarm.distance/1000) km"
            mapView.addAnnotation(annotation)
            
            
        }
        
    }
    
    
    func removeAnnotation(with title: String) {
        for annotation in self.mapView.annotations {
            guard let annotationTitle = annotation.title else { continue }
            if annotationTitle == title {
                self.mapView.removeAnnotation(annotation)
                AlarmManager.shared.removeAlarm(for: annotationTitle!)
            }
        }
    }
    
    
    
    
    // alert
    
    func showAlert(for alarm: Alarm) {

        // Alarm sound and vibration
        
        AudioServicesPlaySystemSound(SystemSoundID(1304))
        
        AudioServicesPlaySystemSound(SystemSoundID(4095))
        
        
        
        
        if !showingAlert {
            showingAlert = true
            let Alert = UIAlertController(title: "Stop Snoozing!", message: "You Are Nearly At Your Destination", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
                self.showingAlert = false
        
            })
            Alert.addAction(action)
            
            present(Alert, animated: true, completion: nil)
        }
    }
    
    

        // local notification
    
    func initNotificationSetupCheck() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
        { (success, error) in
            if success {
                print("Permission Granted")
            } else {
                print("There was a problem!")
            }
        }
    }
    
    func showNotification(for alarm: Alarm) {
        let notification = UNMutableNotificationContent()
        notification.title = "Stop Snoozing!"
        notification.body = "You are \(alarm.distance/1000) kilometers from \(alarm.name)."
        AudioServicesPlaySystemSound(SystemSoundID(1304))
        AudioServicesPlaySystemSound(SystemSoundID(4095))
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "notification1", content: notification, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "") {
            annotationView.annotation = annotation
            return annotationView
        } else {
            let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:"")
            annotationView.isEnabled = true
            annotationView.canShowCallout = true
            
            let btn = UIButton(type: .detailDisclosure)
            annotationView.rightCalloutAccessoryView = btn
            return annotationView
        }
    
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    
        removeAnnotation(with: view.annotation!.title!!)
        
        
    }
    
    
}


