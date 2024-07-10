//
//  Thread.swift
//  PullToRefresh
//
//  Created by Vinh on 15/06/2024.
//

import SwiftUI

struct ThreadOverlayTopIcon: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: 0.31043*width, y: 0.33789*height))
            path.addCurve(to: CGPoint(x: 0.20826*width, y: 0.44724*height), control1: CGPoint(x: 0.31043*width, y: 0.33789*height), control2: CGPoint(x: 0.20837*width, y: 0.44715*height))
            path.addCurve(to: CGPoint(x: 0.16685*width, y: 0.53676*height), control1: CGPoint(x: 0.20815*width, y: 0.44724*height), control2: CGPoint(x: 0.16674*width, y: 0.53676*height))
            path.addCurve(to: CGPoint(x: 0.20609*width, y: 0.45229*height), control1: CGPoint(x: 0.16685*width, y: 0.53676*height), control2: CGPoint(x: 0.20609*width, y: 0.45229*height))
            path.addCurve(to: CGPoint(x: 0.16685*width, y: 0.53676*height), control1: CGPoint(x: 0.20609*width, y: 0.45229*height), control2: CGPoint(x: 0.16696*width, y: 0.53648*height))
            path.addCurve(to: CGPoint(x: 0.20576*width, y: 0.45295*height), control1: CGPoint(x: 0.16685*width, y: 0.53676*height), control2: CGPoint(x: 0.20587*width, y: 0.45295*height))
            path.move(to: CGPoint(x: 0.96761*width, y: 0.3275*height))
            path.addLine(to: CGPoint(x: 0.98707*width, y: 0.41356*height))
            return path
        }
}
