//
//  BaseViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 16/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let ui = UIActivityIndicatorView()
        ui.translatesAutoresizingMaskIntoConstraints = false
        ui.stopAnimating()
        ui.isHidden = true
        ui.style = UIActivityIndicatorView.Style.large
        ui.color = .blue
        return ui
    }()
    
    lazy var emptyView : UIView = {
        let nib = UINib(nibName: "HistoryEmptyView", bundle: nil)
        var emptyView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return emptyView
    }()
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    }
    
    func showMessage(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
