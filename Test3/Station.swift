//
//  Station.swift
//  Test3
//
//  Created by Chloe Hutchings on 30/03/2017.
//  Copyright © 2017 Chloe Hutchings. All rights reserved.
//

import SwiftyJSON
import CoreLocation

class Station {
    var name: String
    var coordinates: CLLocation
    
    // the init function is where we set stuff up. 
    // It's called like this - Station(json)
    init(json: JSON) {
        name = json["stationname"].stringValue
        
        let coordinateArray = json["ospoint"]["coordinates"].arrayValue
        coordinates = CLLocation(latitude: CLLocationDegrees(coordinateArray[0].floatValue), longitude: CLLocationDegrees(coordinateArray[1].floatValue))
    }
    
}
