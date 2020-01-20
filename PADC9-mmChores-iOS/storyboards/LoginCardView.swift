//
//  LoginCardView.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import UIKit

class LoginCardView : UIView {
    @IBInspectable var cornerRadius: CGFloat = 5
    override func layoutSubviews() {
            layer.cornerRadius = cornerRadius
            layer.borderWidth = 1
        layer.borderColor = UIColor.clear.cgColor
            layer.masksToBounds = false
    }
}

