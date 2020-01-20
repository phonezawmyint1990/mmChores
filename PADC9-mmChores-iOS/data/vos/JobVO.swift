//
//  JobVO.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 13/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
class JobVO {
    
    var fullDescription : String = ""
    var id : String = ""
    var jobDate : String = ""
    var jobTime : String = ""
    var location : String = ""
    var photoUrl : String = ""
    var price : String = ""
    var shortDescription : String = ""
    var isActive : Bool = true
    var appliedFreelancersArray : Array = [String]()
    var chosenFreelancerArray : Array = [String]()
    var postedEmployersArray : Array = [String]()
    var appliedFreelancers : [User] = []
    var chosenFreelancers : [User] = []
    
   
    init() {
        
    }
    
    init?(data: [String : Any]){

        let fullDescription = data["fullDescription"] as! String
            let id = data["id"] as! String
            let jobDate = data["jobDate"] as! String
            let jobTime = data["jobTime"] as! String
            let location = data["location"] as! String
            let photoUrl = data["photoUrl"] as! String
            let price = data["price"] as! String
            let shortDescription = data["shortDescription"] as! String
            let appliedFreelancersArray = data["appliedFreelancersArray"] as! Array<String>
            let chosenFreelancerArray = data["chosenFreelancerArray"] as! Array<String>
            let postedEmployersArray = data["postedEmployersArray"] as! Array<String>
            let isActive = data["isActive"] as! Bool

        self.fullDescription = fullDescription
        self.id = id
        self.jobDate = jobDate
        self.jobTime = jobTime
        self.location = location
        self.photoUrl = photoUrl
        self.price = price
        self.shortDescription = shortDescription
        self.isActive = isActive
        self.appliedFreelancersArray = appliedFreelancersArray
        self.chosenFreelancerArray = chosenFreelancerArray
        self.postedEmployersArray = postedEmployersArray

    }
    
    

     
}
