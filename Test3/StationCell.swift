import UIKit

class StationCell: UITableViewCell {
    
    var station: Station!
    var hideFavouriteButton = false
    
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var favButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLable.text = "(\(station.code))" + " " + station.name
        if (hideFavouriteButton) {
            favButton.alpha = 0
            favButton.isUserInteractionEnabled = false
        }
        if StationManager.shared.isFavourite(station) {
            titleLable.alpha = 1.0
            // Set image to Filled In
             favButton.setImage(#imageLiteral(resourceName: "RedFilledHeart"), for: .normal)
        } else {
            titleLable.alpha = 1.0
            // Set image to Outline
             favButton.setImage(#imageLiteral(resourceName: "OutlineHeart"), for: .normal)
        }
    }
    
    @IBAction func fav(_ sender: Any) {
        StationManager.shared.toggleFavourite(station)
    }

}
