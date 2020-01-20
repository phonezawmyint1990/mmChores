//
//  HomeScreenDelegate.swift
//  PADC9-mmChores-iOS
//
//  Created by Waiphyoag on 08/12/2019.
//  Copyright © 2019 Zaw Htet Naing. All rights reserved.
//

import Foundation
protocol HomeScreenDelegate {
    
    func addJobPost()
    func showJobDetail(data : JobVO)
}
