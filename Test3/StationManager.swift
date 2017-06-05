import Foundation
import SwiftyJSON
import Alamofire

class StationManager {
    
    static let shared = StationManager()
    
    var stations = [Station]()
    var favourites = [String]()
    
    private init() {
        
        if let favourites = UserDefaults.standard.value(forKey: "Favourites") as? [String] {
            self.favourites = favourites
        }
        
    }
    
    func updateStation(with jsonData: JSON) {
        stations.removeAll()
        let array = jsonData["result"].arrayValue // Creates an array of JSON data
        
        // For each station...
        for jsonStation in array {
            // Initiate a new Station, and add it to the array from up the top
            let station = Station(json: jsonStation)
            stations.append(station)
        }
        
    }
    
    
    func loadStations(completionHandler:@escaping (Bool) -> ()) {
        Alamofire.request("https://raw.githubusercontent.com/chutchings95/SnoozeStation/master/Test3/nearest.json?").response { response in
            
            guard let data = response.data else {
                completionHandler(false)
                return
            }
            
            let jsonData = JSON(data: data)
            
            StationManager.shared.updateStation(with: jsonData)
            
            completionHandler(true)
            
        }
    }
    
    
    func toggleFavourite(_ station: Station) {
        
        
        if isFavourite(station) {
            favourites.remove(at: favourites.index(of: station.code)!)
        } else {
            favourites.append(station.code)
        }
        UserDefaults.standard.setValue(favourites, forKey: "Favourites")
    }
    
    func isFavourite(_ station: Station) -> Bool {
        return favourites.contains(station.code) ? true : false
    }
    
    
    
    
}
    
