//
//  CardView.swift
//  PADC9-mmChores-iOS
//
//  Created by Aung Ko Ko on 07/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
import RxSwift
class SharedApiClient: BaseApiClient{
    static let shaerd = SharedApiClient()
    private override init(){}
}

extension SharedApiClient : IApiClient {
    
}
