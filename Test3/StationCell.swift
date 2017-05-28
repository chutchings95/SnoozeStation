import UIKit

class StationCell: UITableViewCell {
    
    var station: Station!
    
    @IBOutlet var titleLable: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLable.text = "(\(station.code))" + " " + station.name
        if StationManager.shared.isFavourite(station) {
            titleLable.alpha = 1.0
        } else {
            titleLable.alpha = 0.2
        }
    }   
    
    @IBAction func fav(_ sender: Any) {
        StationManager.shared.toggleFavourite(station)
    }

}
