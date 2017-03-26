import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    var showingAlert = false
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    
    {
        let location = locations [0]
        
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        mapView.setRegion(region, animated: true)
        
        // print(location.speed)
        print(location.coordinate)
        // print(location.timestamp)
        
        let destination = CLLocation(latitude: 50.727104, longitude: -1.864576)
        
        if location.distance(from: destination) < 100 {
            print("arrived")
            showAlert()
        }
        
       // print(location.distance(from: location))
        
        self.mapView.showsUserLocation = true
        
    }
    
    var alertController:UIAlertController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
       // if "user"  == "Destination" {
            let overlays = mapView.overlays
            mapView.removeOverlays(overlays)
        
        // showAlert()
        
        manager.delegate = self
        // manager.allowsBackgroundLocationUpdates = true
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
            
        }
    
    
    func showAlert() {

        if !showingAlert {
            showingAlert = true
            let refreshAlert = UIAlertController(title: "Wake Up", message: "You Are Nearly At Your Destination", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
                self.showingAlert = false
            })
            refreshAlert.addAction(action)
            
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    
    


}

