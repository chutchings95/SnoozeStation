import UIKit
import SwiftyJSON
import Alamofire

class SetupViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet var textField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    
    
    var autoComplete: [Station] = []
    var selectedStation: Station?
    
    // Sets up an empty array of Stations
    var currentSelectedStation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        tableView.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        tableView.register(UINib(nibName: "StationCell", bundle: nil), forCellReuseIdentifier: "cell")
    
        StationManager.shared.loadStations { success in
            self.tableView.reloadData()
            print(success)
        }
        
    }

    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let substring = textField.text!
        
        search(substring)
        
        return true
    }
    
    
    
    func search(_ search: String) {
        
        autoComplete.removeAll(keepingCapacity: false)
        
        for station in StationManager.shared.stations {
            if station.name.lowercased().range(of: search.lowercased()) != nil {
                autoComplete.append(station)
            }
        }
        
        tableView.reloadData()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            // Setup new view controller
            let controller = segue.destination as! AlertViewController
            controller.selectedStation = selectedStation!
        }
    }
    
}



extension SetupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StationCell
        let station = autoComplete[indexPath.row]
        cell.station = station
        
        return cell
    }
    
}



extension SetupViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedStation = autoComplete[indexPath.row]
        
        performSegue(withIdentifier: "detail", sender: self)
    }
    
}



