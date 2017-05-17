import UIKit
import SwiftyJSON
import Alamofire

class SetupViewController: UIViewController {
    
    
    
    @IBOutlet var pickerView: UIPickerView!
    

    @IBAction func alarmButton(_ sender: Any) {
    }
    
    // Sets up an empty array of Stations
    var currentSelectedStation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        StationManager.shared.loadSations { success in
            //check the success bool
            self.pickerView.reloadAllComponents()
        }
        
    }
    

    
    
}



extension SetupViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelectedStation = row
    }
    
}




    
    
    func didType() {
        
        var stations = StationManager.shared.searchStations("Bour")
        
        
}


extension SetupViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return StationManager.shared.stations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return StationManager.shared.stations[row].name
    }

}





