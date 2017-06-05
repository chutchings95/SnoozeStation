import Foundation
import CoreLocation


class Alarm {
    
    var name: String
    var coordinates: CLLocationCoordinate2D
    var sound: String
    var distance: Int
    var triggered = false
   
    init(station: Station, sound: String, distance: Int) {
        name = station.name
        coordinates = CLLocationCoordinate2DMake(station.coordinates.coordinate.latitude, station.coordinates.coordinate.longitude)
        self.sound = sound
        self.distance = distance
    }
    
}
