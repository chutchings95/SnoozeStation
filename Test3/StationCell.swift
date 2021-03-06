import UIKit

protocol StationCellDelegate {
    func update()
}

class StationCell: UITableViewCell {
    
    var station: Station!
    var hideFavouriteButton = false
    var delegate: StationCellDelegate?
    
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
          // Set image to Filled In
             favButton.setImage(#imageLiteral(resourceName: "RedFilledHeart"), for: .normal)
        } else {
            // Set image to Outline
             favButton.setImage(#imageLiteral(resourceName: "OutlineHeart"), for: .normal)
        }
        
    
    }
    
    
    @IBAction func fav(_ sender: Any) {
        StationManager.shared.toggleFavourite(station)
        delegate?.update()
    }

}
