//
//  HeaderUICollectionViewCell.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit

class HeaderUICollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var btnPhone: UIButton!
    @IBOutlet weak var ivProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivProfile.layer.cornerRadius = ivProfile.frame.width / 2
        btnPhone.layer.cornerRadius = btnPhone.frame.width / 2
        
        
    }

}
