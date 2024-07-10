//
//  Settings.swift
//  PullToRefresh
//
//  Created by Vinh on 30/06/2024.
//

import SwiftUI
import SwiftData

@Model
class Settings {
    var lastSelectedBottomTab: String = "home"
    var date: Date = Date()
    
    init(lastSelectedBottomTab: String, date: Date) {
        self.lastSelectedBottomTab = lastSelectedBottomTab
        self.date = date
    }
}
