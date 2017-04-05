import UIKit
import SwiftyJSON

class SetupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet var pickerView: UIPickerView!
    
    
    
  
    @IBAction func alarmButton(_ sender: Any) {
    }
    
    // Sets up an empty array of Stations
    var stations = [Station]()
    var pickerStations = [Station]()
    var currentSelectedStation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        // Gets the data from the locally stored nearest.json file
        if let path = Bundle.main.path(forResource: "nearest", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    // Got json data
                    parseStations(json: jsonObj)
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    // This function will loop through the json above
    func parseStations(json: JSON) {
        let array = json["result"].arrayValue // Creates an array of JSON data
        
        // For each station...
        for jsonStation in array {
            // Initiate a new Station, and add it to the array from up the top
            stations.append(Station(json: jsonStation))
        }
        
        pickerStationData()
        
        
        print(stations.count)
        print(stations[30].name)
        print(stations[30].coordinates)
        
    }
    
    func pickerStationData() {
        pickerStations.append(Station(name:"Hamworthy Station", lat: 50.725132, lon:-2.019409))
        pickerStations.append(Station(name:"Poole Station", lat: 50.719448, lon:-1.983180))
        pickerStations.append(Station(name:"Parkstone Station", lat: 50.722855, lon:-1.948145))
        pickerStations.append(Station(name:"Branksome Station", lat: 50.726848, lon:-1.919621))
        pickerStations.append(Station(name:"Bournemouth Station", lat: 50.727104, lon:-1.864576))
        pickerStations.append(Station(name:"Pokesdown Station", lat: 50.730995, lon:-1.825165))
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerStations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerStations[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelectedStation = row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMapVC" {
            
            let mapVC = segue.destination as! ViewController
            mapVC.destination = pickerStations[currentSelectedStation].coordinates
            
        }
    }
    
}
