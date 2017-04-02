import UIKit
import SwiftyJSON

class SetupViewController: UIViewController {
    
    // This sets up an empty array of Stations 🚂
    var stations = [Station]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This code gets the data from the locally stored nearest.json file 🤓
        if let path = Bundle.main.path(forResource: "nearest", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    // We have successfully got the json data !!! ✨🤡
                    parseStations(json: jsonObj)
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // This function will loop through the json we fetched above 🤠
    func parseStations(json: JSON) {
        let array = json["result"].arrayValue // Create an array of JSON data
        
        // For each station...
        for jsonStation in array {
            // Initiate a new Station, and add it to the array from up top 🚉
            stations.append(Station(json: jsonStation))
        }
        
        
        // Print some stuff to make sure it works 🌚
        print(stations.count)
        print(stations[50].name)
        print(stations[50].coordinates)
       
        
        
    }
    
}
