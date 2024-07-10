//
//  Extension.swift
//  PullToRefresh
//
//  Created by Vinh on 19/06/2024.
//

import SwiftUI

// Mark: Offset Modifier
extension View {
    @ViewBuilder
    func offsetPTR(coordinateSpace: String, offset: @escaping (CGFloat)->())->some View {
        self
            .overlay {
                GeometryReader {proxy in
                    let minY = proxy.frame(in: .named(coordinateSpace)).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            offset(value)
                        }
                }
            }
    }
    
    @ViewBuilder
    func offsetOverlay(coordinateSpace: String, isDragging: Bool, offset: @escaping (CGFloat)->())->some View {
//        print("coordinateSpace", coordinateSpace, isDragging)
        
        self
            .overlay {
                GeometryReader {proxy in
                    let minY = proxy.frame(in: .named(coordinateSpace)).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            offset(value)
                        }
                }
            }
    }
}

// Mark: Offset PreferenceKey
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// Border
extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

// Keyboard
extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
