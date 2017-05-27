import Foundation
import SwiftyJSON
import Alamofire

class StationManager {
    
    static let shared = StationManager()
    
    var stations = [Station]()
    
    // var favouriteStations = [Station]()
    
   // StationManager.shared.favouriteStations.append(station)
    
    var stationNames = [String]()
    
    var chosenStation: Station?
    
    private init() {}
    
    func updateStation(with jsonData: JSON) {
        stations.removeAll()
        let array = jsonData["result"].arrayValue // Creates an array of JSON data
        
        // For each station...
        for jsonStation in array {
            // Initiate a new Station, and add it to the array from up the top
            let station = Station(json: jsonStation)
            stations.append(station)
            stationNames.append(station.name)
            
        }
        
        print(stations)
        
    }
    
    
    
    func setStation(station: Station) {
        chosenStation = station
    }
    
    
    
    func loadStations(completionHandler:@escaping (Bool) -> ()) {
        Alamofire.request("https://raw.githubusercontent.com/chutchings95/SnoozeStation/master/Test3/nearest.json?token=AJgWbnHqlfbaF1M4Q26vu65Q3hX02K1aks5ZMAFbwA%3D%3D").response { response in
            
            guard let data = response.data else {
                completionHandler(false)
                return
            }
            
            let jsonData = JSON(data: data)
            
            StationManager.shared.updateStation(with: jsonData)
            
            completionHandler(true)
            
        }
    }
    
}
    
