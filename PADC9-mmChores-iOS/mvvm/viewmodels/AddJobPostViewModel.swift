//
//  AddJobPostViewModel.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 14/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage


class AddJobPostViewModel {
    static let DB_COLLECTION_PATH_JOBS = "jobs"
    var imageReference : StorageReference!
    let imageNameinStorage = UUID().uuidString
    var imageString : String?
  
    static let DB_COLLECTION_PATH_EMPLOYERS = "employers"
    var userObject = [String: Any]()

    let db = Firestore.firestore()

    

    
    func addJobPost(fullDesc : String, jobDate : String, jobTime : String,
                    location : String, photoUrl : String, price : String ,shortDesc : String, isActive : Bool)
    {
        
               let docID=db.collection(AddJobPostViewModel.DB_COLLECTION_PATH_JOBS).document().documentID
               db.collection(AddJobPostViewModel.DB_COLLECTION_PATH_JOBS)
                   .document(docID)
                   .setData([
                       "fullDescription" : fullDesc,
                       "id" : docID,
                       "jobDate" : jobDate,
                       "jobTime" : jobTime,
                       "photoUrl" : imageString!,
                       "location" : location,
                       "price" : price,
                       "shortDescription" : shortDesc,
                       "isActive" : isActive,
                    "appliedFreelancersArray" : [String](),
                    "chosenFreelancerArray" : [String](),
                    "postedEmployersArray" : [UserDefaults.standard.string(forKey: "ID")] ])// Because there is no login yet
                   
        
        
       
        getUserObject(id: UserDefaults.standard.string(forKey: "ID")!){ userDocument in
            guard let userID = userDocument["id"] as? String else {return}
            self.db.collection(AddJobPostViewModel.DB_COLLECTION_PATH_JOBS)
            .document(docID).collection("postedEmployer")
                .document(userID).setData(userDocument)
            
            self.getUserObject(id: UserDefaults.standard.string(forKey: "ID")!) {userDocument in
                guard let userID = userDocument["id"] as? String else {return}
                self.db.collection(AddJobPostViewModel.DB_COLLECTION_PATH_JOBS)
                    .document(docID).updateData([
                        "PostedEmployer":[
                            userID : userDocument
                        ]
                    ])
                
            }
        }
        
        
        
        
        
    }
    
    func getUserObject(id : String, onUserFetched: @escaping ([String: Any]) -> Void){
    
        let userDB = db.collection(AddJobPostViewModel.DB_COLLECTION_PATH_EMPLOYERS).document(id)
        
        userDB.getDocument { (data, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            if let document = data?.data() {
                onUserFetched(document)
                self.userObject = document
            }
        }
               
    }
    
    
    func uploadImageToCloud(ivImage : UIImageView){
        
        imageReference = Storage.storage().reference().child("image").child(imageNameinStorage)
        
        
        guard let image = ivImage.image ,
            let data = image.jpegData(compressionQuality: 0.8)
            else {return}
        
        imageReference.putData(data, metadata: nil) { (data,err) in
            if let err = err {
                print(err.localizedDescription)
            }
            
            self.imageReference.downloadURL { (url, err) in
                if let err = err {
                    print(err.localizedDescription)
                }
                self.imageString = url?.absoluteString
            }
            
        }
        
       
        
    }
}
