import Foundation

class AlarmManager {
    
    
    static let shared = AlarmManager()
    
    var alarms = [Alarm]()
    
    private init () { }
    

    
    
    func setAlarm(for station: Station, withSound: String) {
        let newAlarm = Alarm(station: station, sound: withSound)
        AlarmManager.shared.alarms.append(newAlarm)
    }
    
    
    
    
    
}
