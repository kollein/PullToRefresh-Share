//
//  UICoordinator.swift
//  PullToRefresh
//
//  Created by Vinh on 24/06/2024.
//

import SwiftUI

class UICoordinator: ObservableObject {
    @Published var items: [Item] = sampleItems.compactMap({
        Item(title: $0.title, image: $0.image, previewImage: $0.image)
    })
    // Animation Properties
    let animateViewDuration: CGFloat = 0.21
    let animateViewOnCloseDuration: CGFloat = 0.24
    let detailViewImageHeight: CGFloat = 300
    @Published var selectedItem: Item?
    @Published var animateView: Bool = false
    @Published var showDetailView: Bool = false
    @Published var showDetailViewNoDelay: Bool = false
    @Published var detailViewScrollOffset: CGFloat = 0
    
    func toogleView(show: Bool) {
        if show {
            showDetailViewNoDelay = true
            withAnimation(.easeInOut(duration: animateViewDuration)) {
                animateView = true
            }
            
            // DispatchQueue works correctly with duration than Animation-completionCriteria
            DispatchQueue.main.asyncAfter(deadline: .now() + animateViewDuration) {
                self.showDetailView = true
            }
        } else {
            showDetailViewNoDelay = false
            showDetailView = false
            withAnimation(.easeInOut(duration: animateViewOnCloseDuration)) {
                animateView = false
            }
            
            // DispatchQueue works correctly with duration than Animation-completionCriteria
            DispatchQueue.main.asyncAfter(deadline: .now() + animateViewOnCloseDuration) {
                self.resetAnimationProperties()
            }
        }
    }
    
    func resetAnimationProperties() {
        selectedItem = nil
        detailViewScrollOffset = 0
    }
}
