//
//  LoaderView.swift
//  KupujemProdajemDEMO
//
//  Created by Petar Sakotic on 5/22/24.
//

import UIKit

///
class LoaderView: UIView {
    
    private weak var owner: UIView?
    
    struct Config {
        var autoPresent: Bool = true
        var foregroundColor: UIColor = UIColor.black
        var backgroundColor: UIColor = UIColor.clear
        var useLargeSpinner: Bool = true
    }
    
    /// Default Loader View Config instance with predefined values.
    static var defaultLoaderConfig: LoaderView.Config {

        return LoaderView.Config(
            autoPresent: true,
            foregroundColor: AppConstants.AppTheme.bodyTextColor,
            backgroundColor: AppConstants.AppTheme.textColor.withAlphaComponent(0.2),
            useLargeSpinner: true
        )
    }
        
    class func create(for view: UIView, config: Config = LoaderView.defaultLoaderConfig) -> LoaderView {
        let loader = LoaderView(frame: view.bounds)
        
        let activityIndicator: UIActivityIndicatorView
        activityIndicator = UIActivityIndicatorView(style: config.useLargeSpinner ? .large : .medium)
        activityIndicator.frame = view.bounds
        activityIndicator.color = config.foregroundColor
        activityIndicator.startAnimating()
        loader.addSubview(activityIndicator)
        loader.backgroundColor = config.backgroundColor
        loader.isUserInteractionEnabled = true
        loader.owner = view
        if config.autoPresent { loader.present() }
        return loader
    }
    
    func present() {
        DispatchQueue.main.async {
            if self.superview != nil {
                self.removeFromSuperview()
            }
            self.owner?.addSubview(self)
        }
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            if self.superview != nil {
                self.removeFromSuperview()
            }
        }
    }
}

