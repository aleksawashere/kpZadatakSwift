//
//  ViewController.swift
//  kpZadatakSwift
//
//  Created by Aleksa Dimitrijevic on 3.10.24..
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - Globals
    
    var oglasi: [[Ad]] = []

    @IBOutlet weak var adsTableView: UITableView!
    var currentPage: Int = 1
    var totalPages: Int = 4
    
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var footerTextLabel: UILabel!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Return data source
        self.apiFetchAddsApi(for: currentPage)
        
        // Create Custom Table View Cell from nib
        let nib = UINib(nibName: HomeTableViewCell.identifier, bundle: nibBundle)
        adsTableView.register(nib, forCellReuseIdentifier: HomeTableViewCell.identifier)
        
        //Utils
        self.prepareNavigationBarTheme()
        self.prepareTheme()
    }
    
    
    //MARK: - Utils
    
    func prepareNavigationBarTheme() {
        let logoImage = UIImageView(image: UIImage(named: "logo"))
        logoImage.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoImage
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = AppConstants.AppTheme.textColor
    }
    
    
    func prepareTheme() {
        self.view.backgroundColor = AppConstants.AppTheme.backgroundColor
        self.footerView.backgroundColor = AppConstants.AppTheme.backgroundColor
        self.footerTextLabel.text = "KupujemProdajem © 2022 All rights reserved"
        self.footerTextLabel.textColor = AppConstants.AppTheme.bodyTextColor
    }
    
    //MARK: - API
        
    func apiFetchAddsApi(for page: Int) {
        
        let loader = LoaderView.create(for: self.view)
        
        JSONManager.shared.readFromFile(for: page) { result in
            loader.dismiss()
            switch result {
            case .success(let model):
                    self.totalPages = model.totalPages
                    if self.oglasi.count < model.totalPages {
                        self.oglasi.append(model.ads)
                    }
                    self.currentPage = model.currentPage
                    DispatchQueue.main.async {
                    self.adsTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }


    //MARK: - TableViewDataSource and TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return oglasi.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oglasi[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
           let ad = oglasi[indexPath.section][indexPath.row]
           
           cell.configureUI(model: ad, isAddDeleted: false)
           return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Hide first section
        if section == 0 {
            return nil
        }
        
        // Create header view for sections
        let headerView = UIView()
        headerView.backgroundColor = AppConstants.AppTheme.whiteBackground
        
        let label = UILabel()
        label.text = "\(section + 1) od \(totalPages)"
        label.textColor = AppConstants.AppTheme.bodyTextColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == oglasi.count - 1 && indexPath.row == oglasi[indexPath.section].count - 1 && currentPage < totalPages {
            apiFetchAddsApi(for: currentPage + 1)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let ad = oglasi[indexPath.section][indexPath.row]
        DispatchQueue.main.async {
            let viewController = AdDetailsViewController.instantiate(ad: ad)!
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 40
        }
    }
    
}

