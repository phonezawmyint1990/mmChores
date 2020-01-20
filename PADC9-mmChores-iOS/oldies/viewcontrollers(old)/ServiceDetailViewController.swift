//
//  ServiceDetailViewController.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 08/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit

class ServiceDetailViewController: UIViewController {

    @IBOutlet weak var viewPrice: UIView!
    @IBOutlet weak var viewOnceInAMonth: UIView!
    @IBOutlet weak var viewOneIn2Weeks: UIView!
    @IBOutlet weak var viewOneTime: UIView!
    @IBOutlet weak var viewWeekly: UIView!
    @IBOutlet weak var viewHalfDay: UIView!
    @IBOutlet weak var viewAllDay: UIView!
    @IBOutlet weak var viewFullAddress: UIView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var view_components: UIView!
    @IBOutlet weak var btnConfirm: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    fileprivate func setupView() {
        view_components.layer.cornerRadius = 50
        
        
        viewAddress.layer.borderWidth = 1
        viewAddress.layer.cornerRadius = 8
        viewAddress.layer.borderColor = UIColor(named: "PrimaryColor")?.cgColor
        
        viewFullAddress.layer.borderWidth = 1
        viewFullAddress.layer.cornerRadius = 8
        viewFullAddress.layer.borderColor = UIColor(named: "PrimaryColor")?.cgColor
        
        btnConfirm.layer.cornerRadius = 8
        
        
       
        
        makeBorderColor(view: viewHalfDay)
        makeBorderColor(view: viewAllDay)
        makeBorderColor(view: viewWeekly)
        makeBorderColor(view: viewPrice)
         makeBorderColor(view: viewOneTime)
         makeBorderColor(view: viewOnceInAMonth)
         makeBorderColor(view: viewOneIn2Weeks)
        
    }

    fileprivate func makeBorderColor(view : UIView) {
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.separator.cgColor
    }
    
    
 
    @IBAction func onTapBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
