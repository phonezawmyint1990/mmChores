//
//  HomeScreenViewModel.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 13/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import FirebaseFirestore
import RxSwift
import RxCocoa


class HomeScreenViewModel : BaseViewModel {
    static let DB_COLLECTION_PATH = "jobs"
    var result : [JobVO] = []
    var listener : ListenerRegistration!
    var userNameDefault : String = UserDefaults.standard.string(forKey: "ID")!
    static let applied_person = "appliedFreelancers"
    
    func baseQuery() -> Query {
        return Firestore.firestore().collection(HomeScreenViewModel.DB_COLLECTION_PATH)
        
    }
    
    var query : Query? {
        didSet {
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    func requestData(tableView : UITableView) {
        
        query?.whereField("postedEmployersArray", arrayContains: userNameDefault)
            .whereField("isActive", isEqualTo: true)
            .addSnapshotListener({ (querySnapShot, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                }

                let jobs = querySnapShot?.documents.map({ (document) -> JobVO in
                    
                    if let job = JobVO(data : document.data()){
                        return job
                    } else {
                        return JobVO()
                        
                    }
                })
                
                self.result = jobs ?? []
                tableView.reloadData()
            })
        
        
    }
    
}
