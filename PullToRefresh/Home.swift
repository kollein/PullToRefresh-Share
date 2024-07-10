//
//  Home.swift
//  PullToRefresh
//
//  Created by Vinh on 24/06/2024.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var coordinator: UICoordinator
    
    var body: some View {
        VStack {
            CustomRefreshableView {
                Spacer()
                    .frame(height: 14)
                    
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 4), count: 2), spacing: 0) {
                    ForEach(coordinator.items) {item in
                        GridImageView(item)
                            .padding(.bottom, 38)
                            .overlay(alignment: .bottom) {
                                HStack {
                                    Text("800 đ · Bán 1kg vàng ngon bổ rẻ")
                                        .font(.system(size: 16, weight: .medium))
                                        .frame(height: 16)
                                        .lineLimit(1)
                                        .padding(.bottom, 14)
                                        .padding(.leading, 6)
                                    Spacer()
                                }
                            }
                            .onTapGesture {
                                coordinator.selectedItem = item
                            }
                    }
                }
                
                // Compensate for bottom tab bar
                Spacer()
                    .frame(height: store.bottomTabHeight)
            } onRefresh: {
                print("onRefresh:fetching...!")
                try? await Task.sleep(nanoseconds: 500_000_000)
                print("onRefresh:done!")
            }
        }
        .background(Color.white)
        .allowsHitTesting(coordinator.selectedItem == nil)
        .overlay {
            if coordinator.selectedItem != nil {
                Detail()
            }
        }
        .overlayPreferenceValue(HeroKey.self) {value in
            if let selectedItem = coordinator.selectedItem,
               let sAnchor = value[selectedItem.id + "SOURCE"],
               let dAnchor = value[selectedItem.id + "DEST"] {
                HeroLayer(item: selectedItem, sAnchor: sAnchor, dAnchor: dAnchor)
                //                    .overlay(Rectangle().inset(by: 0).stroke(lineWidth: 10).fill(Color.green))
            }
        }
    }
    
    // Image View
    @ViewBuilder
    func GridImageView(_ item: Item) -> some View {
        GeometryReader{
            let size = $0.size
            
            Rectangle()
                .fill(.clear)
                .anchorPreference(key: HeroKey.self, value: .bounds, transform: { anchor in
                    return [item.id + "SOURCE": anchor]
                })
            
            if let previewImage = item.previewImage {
                Image(uiImage: previewImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .opacity(coordinator.selectedItem?.id == item.id ? 0 : 1)
            }
        }
        .frame(height: 184)
        .contentShape(.rect)
    }
}

