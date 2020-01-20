//
//  LoginViewModel.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 09/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class LoginViewModel {
    public func checkUser(userId: String,findKey: String) -> Observable<String> {
        return AuthenticationService.shared.checkUser(userId: userId,findKey: findKey).subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
       }
}
