//
//  Recent.swift
//  PullToRefresh
//
//  Created by Vinh on 30/06/2024.
//

import SwiftUI
import SwiftData

@Model
class RecentProduct {
    var id: String
    var date: Date = Date()
    
    init(id: String, date: Date) {
        self.id = id
        self.date = date
    }
}
