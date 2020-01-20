//
//  RegisterService.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 12/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseFirestore
import Firebase

protocol AuthenticationServiceProtocol {
    func register(user: User) -> Observable<String>
    func checkUser(userId:String, findKey: String) -> Observable<String>
    func findByUserId(userId: String) -> Observable<User>
}

class AuthenticationService: AuthenticationServiceProtocol {
        let db = Firestore.firestore()
        static let shared : AuthenticationService = AuthenticationService()
        private init(){ }
    
    func register(user: User) -> Observable<String> {
        return Observable<String>.create { (observer) -> Disposable in
            let docId = self.db.collection(DB_COLLECTION_PATH).document().documentID
            self.db
                .collection(DB_COLLECTION_PATH)
                .document(docId)
                .setData([
                         "name": user.name ?? "" ,
                         "email": user.email ?? "" ,
                         "dob": user.dob ?? "",
                         "id":  "\(docId)" ?? "",
                         "phoneNo": user.phoneNo ?? "",
                         "photoUrl": user.photoUrl ?? "",
                         "facebookID": user.facebookId ?? "",
                         "googlePlusID": user.googlePlusId ?? ""])
            UserDefaults.standard.set(docId, forKey: USERDEFAULT_ID_KEY)
            observer.onNext(REGISTER_SUCCESS)
            return Disposables.create()
        }
     
    }
    
    func checkUser(userId:String, findKey: String) -> Observable<String> {
         return Observable<String>.create { (observer) -> Disposable in
             let query = self.db.collection(DB_COLLECTION_PATH).whereField(findKey, isEqualTo: userId)
             query.getDocuments { (querySnapshot, err) in
             print("querySnapshot",querySnapshot)
             if let docs = querySnapshot?.documents {
                 if docs != [] {
                     print("Docs",docs)
                     for docSnapshot in docs {
                    guard let responseUser = User(data: docSnapshot.data()) else {
                         return
                     }
                        UserDefaults.standard.set(responseUser.id, forKey: USERDEFAULT_ID_KEY)
                        print("Response \(findKey) User => FBID :: \(responseUser.facebookId) //// GOOGLEPLUS :: \(responseUser.googlePlusId)")
                         }
                     observer.onNext(CHECK_USER_SUCCESS)
                 }else {
                    observer.onNext(CHECK_USER_NOTSUCCESS)
                }
                 }
             }
             return Disposables.create()
         }
     }
    
    
    func findByUserId(userId: String) -> Observable<User>{
        return Observable<User>.create { (observer) -> Disposable in
            let query = self.db.collection(DB_COLLECTION_PATH).document(userId)
            query.getDocument { (document, error) in
                if let doc = document.flatMap({
                  $0.data().flatMap({ (data) in
                    return User(data: data)
                  })
                }) {
                    observer.onNext(doc)
                    print("Document: \(doc)")
                } else {
                    print("Document does not exist")
                }
            }
            return Disposables.create()
        }
    }


}
