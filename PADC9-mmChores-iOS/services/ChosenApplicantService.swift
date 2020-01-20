//
//  ChosenApplicantServicw.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 19/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseFirestore
import Firebase

class ChosenApplicantService {
     let db = Firestore.firestore()
    
    func findChosenApplicant(jobId : String) -> Observable<[User]> {
        return Observable<[User]>.create { (observer) -> Disposable in
            let query = self.db.collection(JobDetailViewModel.DB_COLLECTION_PATH).document(jobId)
            .collection("chosenFreelancer")
            query.addSnapshotListener{ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                    observer.onNext((querySnapshot?.documents.map{User(data: $0.data())})! as! [User])
                }
            }
            return Disposables.create()
        }
    }
}
