//
//  HistoryViewModel.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 15/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HistoryViewModel {
    public func findAllHistory() -> Observable<[JobVO]>{
        return HistoryService.shared.findAllHistory().subscribeOn(ConcurrentDispatchQueueScheduler.init(queue: DispatchQueue.global()))
    }
}
