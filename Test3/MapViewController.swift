import UIKit
import MapKit
import CoreLocation
import AVFoundation
import AudioToolbox


class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBAction func mapBackButton(_ sender: Any) {
    }
    @IBAction func cancelAlertButton(_ sender: Any) {
    }
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var distanceLabel: UILabel!

    var showingAlert = false 
    
    let manager = CLLocationManager()
    
    var alarm: String?
    var distanceFrom: Int?
    
    var destination: CLLocation?
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    
    {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        mapView.setRegion(region, animated: true)
        
        guard destination != nil else { return }
        
        print("coords")
        print(location.coordinate)
        print(destination!.coordinate)
        
        let distanceFromDestination = location.distance(from: destination!)
        
        distanceLabel.text = String(format: "%.2f km", ceil(Double(distanceFromDestination/1000)*100)/100)
        
        print(distanceFromDestination)
        
        if distanceFromDestination < Double(distanceFrom! * 1000) {
            print("arrived")
            showAlert()
        }
        
        
        self.mapView.showsUserLocation = true
        
    }
    
    var alertController:UIAlertController?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.setUserTrackingMode(.follow, animated: true)
        
        manager.delegate = self
        manager.allowsBackgroundLocationUpdates = true
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
            
        }
    
    
    func showAlert() {

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

    
}

