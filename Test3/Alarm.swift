import Foundation
import CoreLocation


class Alarm {
    
    var name: String
    var coordinates: CLLocation
    var sound: String
   
    init(station: Station, sound: String) {
        name = station.name
        coordinates = station.coordinates
        self.sound = sound
    }
    
}
