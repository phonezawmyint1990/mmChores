//
//  HistoryJobListTableViewCell.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 11/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit

class HistoryJobListTableViewCell: UITableViewCell {

    @IBOutlet weak var ivHistroyProfile: UIImageView!
    @IBOutlet weak var lblShortDescription: UILabel!
    @IBOutlet weak var lblFullDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    var mdata: JobVO? {
        didSet{
            lblShortDescription.text = mdata?.shortDescription
            lblPrice.text = mdata?.price
            lblFullDescription.text = mdata?.fullDescription
            ivHistroyProfile.sd_setImage(with: URL(string: mdata!.photoUrl))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ivHistroyProfile.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.selectionStyle = .none
    }
    
    
}
