//
//  Detail.swift
//  PullToRefresh
//
//  Created by Vinh on 24/06/2024.
//

import SwiftUI

struct Detail: View {
    @EnvironmentObject var coordinator: UICoordinator
    
    var body: some View {
        
        VStack {
            GeometryReader {
                let size = $0.size
                
                CustomDraggableView(showIndicator: false) {
                    if let selectedItem = coordinator.selectedItem {
                        VStack {
                            ImageView(selectedItem, size: size)
                                .background {
                                    if let selectedItem = coordinator.selectedItem {
                                        Rectangle()
                                            .fill(.white)
                                            .anchorPreference(key: HeroKey.self, value: .bounds, transform: { anchor in
                                                return [selectedItem.id + "DEST": anchor]
                                            })
                                    }
                                }
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            coordinator.toogleView(show: true)
        }
    }
    
    @ViewBuilder
    func ImageView(_ item: Item, size: CGSize) -> some View {
        if let image = item.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: coordinator.detailViewImageHeight)
                .clipped()
                .contentShape(.rect)
        }
    }
}
