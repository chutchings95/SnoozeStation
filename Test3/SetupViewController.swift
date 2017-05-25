import UIKit
import SwiftyJSON
import Alamofire

class SetupViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBAction func stationBackButton(_ sender: Any) {
    }
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    var autoComplete: [Station] = []
    
    // Sets up an empty array of Stations
    var currentSelectedStation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        tableView.delegate = self
        tableView.register(StationCell.self, forCellReuseIdentifier: "cell")
        
        StationManager.shared.loadStations { success in
            //check the success bool
            print(success)
        }
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return autoComplete.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StationCell
        
        let index = indexPath.row as Int
        
        cell.textLabel!.text = autoComplete[index].name
        
        
        return cell
    }
    
    

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        searchAutocompleteEntriesWithSubstring(substring)
        
        return true
    }
    
    func searchAutocompleteEntriesWithSubstring(_ substring: String) {
        autoComplete.removeAll(keepingCapacity: false)
        
        for key in StationManager.shared.stations {
            
            let myString:NSString! = key.name as NSString
            
            let substringRange :NSRange! = myString.range(of: substring)
            
            if (substringRange.location  == 0) {
                autoComplete.append(key)
            }
        }
        
        tableView.reloadData()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedCell: StationCell = tableView.cellForRow(at: indexPath)! as! StationCell
        
        textField.text = selectedCell.textLabel!.text!
        StationManager.shared.chosenStation = selectedCell.station
        
    }
    
    
}

class StationCell: UITableViewCell {
    var station: Station?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


