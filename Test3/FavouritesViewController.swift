import UIKit

class FavouritesViewController: UIViewController {
    

    
    @IBOutlet var tableView: UITableView!
    
    var stationsLoaded: Bool = false
    var selectedStation: Station?
    var favouriteStations = [Station]()
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        tableView.delegate = self
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "<", style: .plain, target: self, action: nil)
        
        tableView.register(UINib(nibName: "StationCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        StationManager.shared.loadStations { success in
            self.getFavouriteStations()
            self.tableView.reloadData()
        }
    
        
    }
    
    
    
    func getFavouriteStations() {
        
        for stationCode in StationManager.shared.favourites {
            if let station = StationManager.shared.stations.filter({$0.code == stationCode}).first {
                favouriteStations.append(station)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            // Setup new view controller
            let controller = segue.destination as! AlertViewController
            controller.selectedStation = selectedStation!
        }
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath:                              IndexPath) {
        
            if (editingStyle == .delete) {
            
            favouriteStations.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        
        }

    }


extension FavouritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedStation = favouriteStations[indexPath.row]
        
        performSegue(withIdentifier: "detail", sender: self)
    }
}

extension FavouritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StationCell
        
        cell.station = favouriteStations[indexPath.row]
        cell.hideFavouriteButton = true
        
        cell.prepareForReuse()
        
        return cell
        
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteStations.count
    }
}


