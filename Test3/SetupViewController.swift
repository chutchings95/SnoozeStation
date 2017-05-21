import UIKit
import SwiftyJSON
import Alamofire

class SetupViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var searchStation: UITextField!
    
    @IBAction func stationBackButton(_ sender: Any) {
    }

    
    
    @IBAction func customiseAlertButton(_ sender: Any) {
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
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }

}





