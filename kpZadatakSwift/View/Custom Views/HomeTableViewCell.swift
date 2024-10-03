//
//  HomeTableViewCell.swift
//  kpZadatakSwift
//
//  Created by Aleksa Dimitrijevic on 3.10.24..
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    //MARK: - Globals
    
    class var identifier: String { return "HomeTableViewCell" }
    
    @IBOutlet weak var adImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var isImageHire: UIImageView!
    
    //MARK: - init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Postavljanje slike da popuni prostor
        adImageView.contentMode = .scaleAspectFill
        adImageView.clipsToBounds = true
    }

    //MARK: - Utils
    
    func configureUI(model: Ad, isAddDeleted: Bool) {
        self.adImageView.image = nil // Reset before assigning new image
        
        if !isAddDeleted {
            self.backgroundColor = AppConstants.AppTheme.whiteBackground
            self.adImageView.prepareImageFromServerSide(urlString: model.photo)
            self.titleLabel.text = model.name
            self.titleLabel.textColor = AppConstants.AppTheme.titleTextColor
            self.descriptionLabel.text = model.location
            self.descriptionLabel.textColor = AppConstants.AppTheme.bodyTextColor
            self.priceLabel.text = model.fullPrice
            self.priceLabel.textColor = AppConstants.AppTheme.redColor
            self.favoriteImageView.image =  model.favouriteCount > 20 ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            self.favoriteImageView.tintColor = AppConstants.AppTheme.titleTextColor
            self.isImageHire.image = UIImage(named: "vrh")
        } else {
            self.backgroundColor = AppConstants.AppTheme.whiteBackground
            self.adImageView.image = AppConstants.AppTheme.backgroundImage
            self.titleLabel.text = "Oglas je obrisan"
            self.titleLabel.textColor = AppConstants.AppTheme.bodyTextColor
            self.descriptionLabel.isHidden = true
            self.priceLabel.isHidden = true
            self.favoriteImageView.image = UIImage(systemName: "star")?.alpha(0.1)
            self.favoriteImageView.isHidden = true
            self.isImageHire.isHidden = true
        }

    }
    

}
