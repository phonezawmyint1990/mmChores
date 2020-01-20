//
//  JobsPostsTableViewCell.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 10/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import UIKit
import SDWebImage

class JobsPostsTableViewCell: UITableViewCell {

    @IBOutlet weak var ivJobPic: UIImageView!
    @IBOutlet weak var lblLongDesc: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblShortDesc: UILabel!
   
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblApplicantUser: UILabel!
    var mData : JobVO?
    {
        didSet {
            
            if let data = mData {
            lblShortDesc.text = data.shortDescription
            lblLongDesc.text = data.fullDescription
            ivJobPic.sd_setImage(with: URL(string: data.photoUrl), completed: nil)
            lblPrice.text = "\(data.price)  MMK"
            lblDate.text = data.jobDate
            lblTime.text = data.jobTime
            lblLocation.text = data.location
                
                
                if (mData?.appliedFreelancersArray.count ?? 0 > 0 && mData?.chosenFreelancerArray.isEmpty == true){
                          lblApplicantUser.text = "အလုပ်လျှောက်ထားသူ \(mData?.appliedFreelancersArray.count ?? 0) ဦး"

                          
                } else if ( mData?.chosenFreelancerArray.count ?? 0 > 0){
                          lblApplicantUser.text = "အလုပ်ခန့်ပြီးပါပြီ"
                    

                      }
                else {
                    lblApplicantUser.text = "အလုပ်လျှောက်ထားသူ မရှိသေးပါ"
                }
             
            }
        }
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpView()
        
    }
    
    fileprivate func setUpView(){
        
        ivJobPic.layer.cornerRadius = 8
      
       
                    
                    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
