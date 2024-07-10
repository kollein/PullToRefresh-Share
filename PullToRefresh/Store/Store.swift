//
//  Store.swift
//  PullToRefresh
//
//  Created by Vinh on 23/06/2024.
//

import SwiftUI

class Store: ObservableObject {
    @Published var silentMode: Bool = false
    @Published var bottomTabs: [BottomTab] = bottomTabItems.compactMap({
        BottomTab(id: $0.id, title: $0.title, image: $0.image, imageFill: $0.imageFill)
    })
    @Published var selectedTabId: String = "home"
    @Published var selectedTabIdNoAnim: String = "home"
    @Published var prevSelectedTabId: String = ""
    @Published var animateBottomTabColor: Bool = false
    let bottomTabHeight: CGFloat = 76
    let bottomTabIgnoreSafeAreaHeight: CGFloat = 34
    
    // Searchable
    @Published var isPresented = false
    @Published var scrollOffset: CGFloat = 0
    
    func selectBottomTab(_ id: String) {
        selectedTabIdNoAnim = id
        withAnimation(.smooth(duration: 0.36)) {
            selectedTabId = id
            prevSelectedTabId = selectedTabId
        }
    }
}
