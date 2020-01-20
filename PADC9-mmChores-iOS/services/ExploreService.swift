//
//  ExploreService.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 15/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseFirestore
import Firebase

protocol ExploreServiceProtocol {
    func findAllExploreJob() -> Observable<[JobVO]>
}


class ExploreService:ExploreServiceProtocol  {
        let db = Firestore.firestore()
        static let shared : ExploreService = ExploreService()
        private init(){ }
    
    func findAllExploreJob() -> Observable<[JobVO]> {
        return Observable<[JobVO]>.create { (observer) -> Disposable in
            let query = self.db.collection(JOB_DB_COLLECTION_PATH).whereField("isActive", isEqualTo: true)
            query.addSnapshotListener{ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                    }
                    observer.onNext((querySnapshot?.documents.map{JobVO(data: $0.data())})! as! [JobVO])
                }
            }
            return Disposables.create()
        }
    }
}
