//
//  ProfileViewModel.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 09/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    public func findByUserId(userId: String) -> Observable<User>{
        return AuthenticationService.shared.findByUserId(userId: userId).subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
    }
}
