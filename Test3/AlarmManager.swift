import Foundation
import CoreLocation


class AlarmManager {
    
    
    static let shared = AlarmManager()
    
    var alarms = [Alarm]()
    
    private init () { }
    
    func setAlarm(for station: Station, withSound: String, atDistance: Double) {
        let newAlarm = Alarm(station: station, sound: withSound, distance: atDistance)
        AlarmManager.shared.alarms.append(newAlarm)
    }
    
//    func closestAlarm(userLocation: CLLocation) -> Alarm? {
//        
//        var closestAlarm = AlarmManager.shared.alarms.first
//        
//        for alarm in AlarmManager.shared.alarms {
//            
//        }
//        
//        return closestAlarm
//    }
    

}
