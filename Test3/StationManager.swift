import Foundation
import SwiftyJSON
import Alamofire

class StationManager {
    
    static let shared = StationManager()
    
    var stations = [Station]()
    
    private init() {}
    
    func updateStation(with jsonData: JSON) {
        stations.removeAll()
        let array = jsonData["result"].arrayValue // Creates an array of JSON data
        
        // For each station...
        for jsonStation in array {
            // Initiate a new Station, and add it to the array from up the top
            stations.append(Station(json: jsonStation))
        }
        
    }
    
    
    
    func searchStations(_ search: String) -> [Station] {
        var results = [Station]()

        
        
        return stations
    }
    
    
    
    func loadSations(completionHandler:@escaping (Bool) -> ()) {
        Alamofire.request("https://raw.githubusercontent.com/chutchings95/SnoozeStation/master/Test3/nearest.json?token=AJgWbjGgAOKPrWVG-pALOjKVFhewqvY0ks5ZIgDLwA%3D%3D").response { response in
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
    
