//
//  Extension.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields

extension UICollectionView {
    
    func registerForCollectionCell(strID: String) {
        
        register(UINib(nibName: strID, bundle: nil), forCellWithReuseIdentifier: strID)
    }
}

extension UITableView{
    func registerForCell(strID: String) {
        register(UINib(nibName: strID, bundle: nil), forCellReuseIdentifier: strID)
    }
}

extension String {
    var isEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}

extension MDCTextField {
    func elevate(elevation: Double) {
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: elevation)
        self.layer.shadowRadius = CGFloat(elevation)
        self.layer.shadowOpacity = 1
    }
}

extension UITableView {
    
func setJobHistoryEmptyView(title: String) {
//            let nib = UINib(nibName: "HistoryEmptyView", bundle: nil)
//            var emptyView = nib.instantiate(withOwner: self, options: nil).first as! UIView
//             emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
//            self.backgroundView = emptyView
//            self.separatorStyle = .none
    
    let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
    
    let imageView = UIImageView()
    emptyView.addSubview(imageView)
    imageView.image = UIImage(named: "job_history_empty_img")
    imageView.contentMode = .scaleAspectFit
    
    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.textColor = UIColor.black
    titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
    emptyView.addSubview(titleLabel)
    
    imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
    imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
    imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
    
    titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
    titleLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
    titleLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
    titleLabel.text = title
    titleLabel.numberOfLines = 0
    titleLabel.textAlignment = .center
    // The only tricky part is here:
    self.backgroundView = emptyView
    self.separatorStyle = .none
    }
    
    func setGeneralEmptyView(title: String, message: String, photo: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let imageView = UIImageView()
        emptyView.addSubview(imageView)
        imageView.image = UIImage(named: photo)
        imageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        emptyView.addSubview(titleLabel)
        
        imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.black
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        emptyView.addSubview(messageLabel)
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
        }
    
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}

extension UIView {
    
    func setEmptyView(title: String, message: String, photo: String) {
//        let emptyView = UIView(frame: CGRect(x: (self.superview?.center.x)!, y: self.superview!.center.y, width: (self.superview?.bounds.size.width)!, height: (self.superview?.bounds.size.height)!))
        
        let emptyView = UIView()
        
        
        let imageView = UIImageView()
        emptyView.addSubview(imageView)
        imageView.image = UIImage(named: photo)
        imageView.contentMode = .scaleAspectFit
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        emptyView.addSubview(titleLabel)
        
        imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.black
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        emptyView.addSubview(messageLabel)
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        // The only tricky part is here:
        self.addSubview(emptyView)
        }
    
    
    func restoreView() {
        self.removeFromSuperview()
    }
}

