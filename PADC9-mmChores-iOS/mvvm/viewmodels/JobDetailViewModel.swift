//
//  JobDetailViewModel.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 15/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import FirebaseFirestore
import RxSwift
import RxRelay

class JobDetailViewModel {
    static let DB_COLLECTION_PATH = "jobs"
    static let applied_person = "appliedFreelancers"
    static let chosen_applicant = "chosenApplicant"
    var mData : JobVO = JobVO()
    var chosenApplicant : [User] = []
    var jobId : String = ""
    
    let userObject = PublishSubject<[User]>()
    var applicant : [User] = []
    
    
    
    let db = Firestore.firestore()
    
    func requestAppliedFreelancers(id : String, onApplicantAppliedSuccess : @escaping () -> Void){
        db.collection(HomeScreenViewModel.DB_COLLECTION_PATH)
            .document(id).collection(HomeScreenViewModel.applied_person)
            .addSnapshotListener { (snapShot, err) in
                if let err = err {
                    print(err.localizedDescription)
                }
                
                let applicantSnapShot = snapShot?.documents.map({ (document) -> User in
                    
                    if let user = User(data : document.data()){
                        return user
                    } else
                    {
                        return User()
                    }
                })
                self.applicant = applicantSnapShot ?? []
                onApplicantAppliedSuccess()
        }
        
    }
    
    func confirmApplicantFromList(userId : String,jobId : String, onConfirmApplicantSuccess : @escaping () -> Void){
        
        getUserObject(userId : userId, jobId : jobId){ userDocument in
            self.db.collection(JobDetailViewModel.DB_COLLECTION_PATH)
                .document(jobId).collection("chosenFreelancer")
                .document(userId).setData(userDocument)
           
            
            self.db.collection(JobDetailViewModel.DB_COLLECTION_PATH)
                .document(jobId)
                .updateData([
                    
                                    "chosenFreelancerArray" : [userId],
                                    "isApplied" : false,
                                    "isFreelancerChosen" : true
                ]){ err in
                    if let err = err{
                        //Error
                        print(err.localizedDescription)
                    } else {
                        //Success
                        onConfirmApplicantSuccess()
                    }
                }
                
        }
        
        
        
        
    }
    
    func getUserObject(userId :String ,jobId : String, onUserFetched: @escaping ([String: Any]) -> Void){
        
        let userDB = db.collection(JobDetailViewModel.DB_COLLECTION_PATH).document(jobId)
            .collection(JobDetailViewModel.applied_person).document(userId)
        
        userDB.getDocument { (data, err) in
            if let err = err {
                print(err.localizedDescription)
            }
            if let document = data?.data() {
                onUserFetched(document)
                
               
               
            }
        }
        
    }
    func finishJobPost(jobId : String){
        
        db.collection(JobDetailViewModel.DB_COLLECTION_PATH).document(jobId)
        .updateData([
            "isActive" : false
        ])
    }
    
    public func findChosenApplicant(jobId : String) -> Observable<[User]>{
     
        return ChosenApplicantService().findChosenApplicant(jobId : jobId)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
    }
    
   public func requestData(jobID : String){
        
        db.collection(HomeScreenViewModel.DB_COLLECTION_PATH)
            .document(jobID).addSnapshotListener { (querySnapShot, err) in
                if let err = err {
                    print(err.localizedDescription)
                }
                let jobs = querySnapShot?.data().map({ (document) -> JobVO in
                                   
                                   if let job = JobVO(data : document){
                                       return job
                                   } else {
                                       return JobVO()
                                       
                                   }
                               })
                               
                self.mData = jobs ?? JobVO()
        }
        
        
    }
    
}
