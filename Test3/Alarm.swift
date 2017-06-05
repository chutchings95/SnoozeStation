import Foundation
import CoreLocation


class Alarm {
    
    var name: String
    var coordinates: CLLocationCoordinate2D
    var sound: String
    var distance: Double
    var triggered = false
    var location: CLLocation
    
    init(station: Station, sound: String, distance: Double) {
        name = station.name
        coordinates = CLLocationCoordinate2DMake(station.coordinates.coordinate.latitude, station.coordinates.coordinate.longitude)
        self.sound = sound
        self.distance = distance
        location = station.coordinates
    }
    
}
