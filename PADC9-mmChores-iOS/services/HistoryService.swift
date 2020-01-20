//
//  HistoryService.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 15/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseFirestore
import Firebase

protocol HistoryServiceProtocol {
    func findAllHistory() -> Observable<[JobVO]>
}

class HistoryService:HistoryServiceProtocol {
        let db = Firestore.firestore()
        static let shared : HistoryService = HistoryService()
        private init(){ }
    
    func findAllHistory() -> Observable<[JobVO]> {
        return Observable<[JobVO]>.create { (observer) -> Disposable in
            let query = self.db.collection(JOB_DB_COLLECTION_PATH)
                .whereField("isActive", isEqualTo: false)
                .whereField("postedEmployersArray", arrayContains: UserDefaults.standard.string(forKey: USERDEFAULT_ID_KEY))
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
