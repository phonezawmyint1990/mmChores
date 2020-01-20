//
//  ExploreJobListTableViewCell.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 11/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import SDWebImage

class ExploreJobListTableViewCell: UITableViewCell {
    @IBOutlet weak var ivJobImage: UIImageView!
    @IBOutlet weak var lblJobDescription: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblJobDate: UILabel!
    @IBOutlet weak var lblJobTime: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    
    var mdata: JobVO? {
        didSet{
            lblJobDescription.text = mdata?.shortDescription
            if let price = mdata?.price {
                lblAmount.text = "\(price) MMK "
            }
            lblJobDate.text = mdata?.jobDate
            lblJobTime.text = mdata?.jobTime
            lblLocation.text = mdata?.location
            ivJobImage.sd_setImage(with: URL(string: mdata!.photoUrl))
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivJobImage.layer.cornerRadius = 8
        ivJobImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = .none
    }
    
}
