//
//  ProfilePicCollectionViewCell.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 11/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import SDWebImage

class ProfilePicCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var btnApply: UIButton!
    @IBOutlet weak var ivProfile: UIImageView!
    
    @IBOutlet weak var lblApplicantName: UILabel!
    
    var delegate : JobDetailDelegate?
    var mData : User?
    {
        didSet {
            ivProfile.sd_setImage(with: URL(string: mData?.photoUrl ?? ""), completed: nil)
            
            lblApplicantName.text = mData?.name ?? ""
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivProfile.layer.cornerRadius = 12
        btnApply.layer.cornerRadius = 8
    }

    @IBAction func onTapApply(_ sender: Any) {
        self.delegate?.onTapApplyApplicant(userId : mData?.id ?? "")
        

       
    }
    
    
}
