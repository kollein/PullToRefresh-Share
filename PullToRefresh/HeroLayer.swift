//
//  HeroLayer.swift
//  PullToRefresh
//
//  Created by Vinh on 24/06/2024.
//

import SwiftUI

struct HeroLayer: View {
    @EnvironmentObject var coordinator: UICoordinator

    var item: Item
    var sAnchor: Anchor<CGRect>
    var dAnchor: Anchor<CGRect>
    var body: some View {
        // GeometryReader helps the hero layer view-animation
        // to be working with the Source/Dest views based on the view-size/view-position
        // which are not allowed to change by any fixed value
        GeometryReader { proxy in
            let sRect = proxy[sAnchor]
            let dRect = proxy[dAnchor]
            let animateView = coordinator.animateView
            
            let viewSize: CGSize = .init(
                width: animateView ? dRect.width : sRect.width,
                height: animateView ? dRect.height : sRect.height
            )
            
            let compensatedScrollOffset = abs(coordinator.detailViewScrollOffset) > coordinator.detailViewImageHeight ? abs(coordinator.detailViewScrollOffset) : 0
            let viewPosition: CGSize = .init(
                width: animateView ? dRect.minX : sRect.minX,
                height: animateView ? dRect.minY + compensatedScrollOffset : sRect.minY
            )
            
            if let image = item.image, !coordinator.showDetailView {
                ImageView(image: image, animateView: animateView, viewSize: viewSize,
                          viewPosition: viewPosition)
            }
        }
    }
    
    @ViewBuilder
    func ImageView(image: UIImage, animateView: Bool, viewSize: CGSize, viewPosition: CGSize) -> some View {
        VStack(spacing: 0) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: viewSize.width, height: viewSize.height)
                .clipped()
                .offset(viewPosition)
                .transition(.identity)
//                .overlay {
//                    VStack {
//                        Text("viewPosition:width " + viewPosition.width.description)
//                            .foregroundColor(.green)
//                        Text("viewPosition:height " + viewPosition.height.description)
//                            .foregroundColor(.green)
//                    }
//                }
        }
    }
}
