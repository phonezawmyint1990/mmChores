//
//  RegisterViewModel.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 09/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel {
    public func requestRegisterData(user:User) -> Observable<String>{
        return AuthenticationService.shared.register(user: user).subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
    }
}
