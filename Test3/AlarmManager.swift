import Foundation

class AlarmManager {
    
    
    static let shared = AlarmManager()
    
    var alarms = [Alarm]()
    
    private init () { }
    
    func setAlarm(for station: Station, withSound: String, atDistance: Int) {
        let newAlarm = Alarm(station: station, sound: withSound, distance: atDistance)
        AlarmManager.shared.alarms.append(newAlarm)
    }
    

}
