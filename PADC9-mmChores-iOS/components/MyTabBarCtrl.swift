//
//  MyTabBar.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 10/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import UIKit
class MyTabBarCtrl: UITabBarController, UITabBarControllerDelegate {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
   }
    
    func setupMiddleButton() {

      
           
         
       }
}
