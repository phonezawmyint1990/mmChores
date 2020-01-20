//
//  User.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 13/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
class User {
    var name: String = ""
    var email: String = ""
    var phoneNo: String = ""
    var dob: String = ""
    var photoUrl: String = ""
    var facebookId: String = ""
    var googlePlusId:String = ""
    var id: String = ""
    
    init() {
        
    }
    
    init?(data: [String:Any]) {
          guard let name = data["name"] as? String,
                let email = data["email"] as? String,
                let phoneNo = data["phoneNo"] as? String,
                let dob = data["dob"] as? String,
                let photoUrl = data["photoUrl"] as? String,
                let facebookId = data["facebookID"] as? String,
                let googlePlusId = data["googlePlusID"] as? String,
            let id = data["id"] as? String else {
                return nil
        }
        
        self.name = name
        self.email = email
        self.phoneNo = phoneNo
        self.dob = dob
        self.photoUrl = photoUrl
        self.facebookId = facebookId
        self.googlePlusId = googlePlusId
        self.id = id
      }
    
}
