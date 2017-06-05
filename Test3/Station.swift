import SwiftyJSON
import CoreLocation

class Station {
    var name: String
    var coordinates: CLLocation
    var code: String
    
    // the init function is where we set stuff up. 
    // It's called like this - Station(json)
    init(json: JSON) {
        name = json["stationname"].stringValue
        code = json["crscode"].stringValue
        
        let coordinateArray = json["latlong"]["coordinates"].arrayValue
        
        if (code == "BMH") {
            print(coordinateArray)
            print(coordinateArray[0].floatValue)
            print(coordinateArray[1].floatValue)
        }
        coordinates = CLLocation(latitude: CLLocationDegrees(coordinateArray[1].floatValue), longitude: CLLocationDegrees(coordinateArray[0].floatValue))
    }
    
}
