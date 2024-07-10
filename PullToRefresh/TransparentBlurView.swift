//
//  TransparentBlurView.swift
//  PullToRefresh
//
//  Created by Vinh on 30/06/2024.
//

import SwiftUI

struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilters: Bool = false
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThickMaterialLight))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let backdropLayer = uiView.layer.sublayers?.first {
                if removeAllFilters {
                    backdropLayer.filters = []
                } else {
                    // Only keep gaussian blur
                    backdropLayer.filters?.removeAll(where: {filter in
                        String(describing: filter) != "gaussianBlur"
                    })
                }
            }
        }
    }
}
