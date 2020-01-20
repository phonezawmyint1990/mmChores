//
//  ProfileTableViewCell.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var lblKey: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
