//
//  AdDetailsViewController.swift
//  kpZadatakSwift
//
//  Created by Aleksa Dimitrijevic on 3.10.24..
//

import UIKit

class AdDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Globals
    
    class var identifier: String { "AdDetailsViewController" }
    
    @IBOutlet weak var adDetailTableView: UITableView!
    @IBOutlet weak var detailContainerView: UIView!
    
    @IBOutlet weak var categoryContainerView: UIView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var adDescriptionView: UIView!
    @IBOutlet weak var adDescriptionTitleLabel: UILabel!
    
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var adImageView: UIImageView!
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var footerTextLabel: UILabel!
    
    private(set) var oglas: Ad!
    private(set) var adDetail: AdDetails?
    
    class func instantiate(ad: Ad) -> AdDetailsViewController? {
        let controller = UIStoryboard.main.instantiateViewController(withIdentifier: identifier) as! AdDetailsViewController
        controller.oglas = ad
        return controller
    }
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set adDetails
        self.apiFetchAdDetails()
        
        // Utils function
        self.prepareNavigationBarTheme()
        self.prepareTheme()
        
        // Set tableView delegates
        adDetailTableView.dataSource = self
        adDetailTableView.delegate = self
        
        // Create Custom Table View Cell from nib
        let nib = UINib(nibName: HomeTableViewCell.identifier, bundle: nibBundle)
        adDetailTableView.register(nib, forCellReuseIdentifier: HomeTableViewCell.identifier)

    }
    
    //MARK: - Utils
    
    func prepareNavigationBarTheme() {
        let logoImage = UIImageView(image: UIImage(named: "logo"))
        logoImage.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoImage
    }
    
    func prepareTheme() {
        
        if let adDetail = adDetail,
           adDetail.desription.count > 3
        {
            
            detailContainerView.isHidden = false
            self.view.backgroundColor = AppConstants.AppTheme.backgroundColor
            
            self.categoryContainerView.backgroundColor = UIColor.white
            self.categoryTitleLabel.text = "Kategorija: "
            self.categoryTitleLabel.textColor = AppConstants.AppTheme.bodyTextColor
            self.categoryDescriptionLabel.text = adDetail.category
            self.categoryDescriptionLabel.textColor = AppConstants.AppTheme.titleTextColor
        
            self.adDescriptionView.backgroundColor = AppConstants.AppTheme.whiteBackground
            self.adDescriptionTitleLabel.text = adDetail.desription.convertText()
            
            self.imageContainerView.backgroundColor = UIColor.white
            self.adImageView.prepareImageFromServerSide(urlString: adDetail.returnURLString)
            
            self.footerView.backgroundColor = AppConstants.AppTheme.backgroundColor
            self.footerTextLabel.text = "KupujemProdajem © 2022 All rights reserved"
            self.footerTextLabel.textColor = AppConstants.AppTheme.bodyTextColor
            
        } else {
            detailContainerView.isHidden = true
        }
        
    }
    
    //MARK: - API
    
    func apiFetchAdDetails() {
        
        let loader = LoaderView.create(for: self.view)
        
        JSONManager.shared.readDetailsFromFile(id: oglas.idToString) { result in
            loader.dismiss()
            switch result {
            case .success(let adDetails):
                self.adDetail = adDetails
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        
    }
    
    //MARK: - TableViewDataSource and TableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.configureUI(model: oglas, isAddDeleted: adDetail?.desription.count ?? 0 < 3 ? true : false)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }

}

