//
//  Overlay.swift
//  PullToRefresh
//
//  Created by Vinh on 23/06/2024.
//

import Foundation

class OverlayStore: ObservableObject {
    @Published var homeLogoScrollupProgress: CGFloat = 0
    @Published var navBarBackgroundAlpha: CGFloat = 0.8
    
    func getSafeAreaOpacity(_ noAlpha: Bool) -> CGFloat {
        return noAlpha ? 1 : homeLogoScrollupProgress <= 0 ? 1 : 0
    }
}
