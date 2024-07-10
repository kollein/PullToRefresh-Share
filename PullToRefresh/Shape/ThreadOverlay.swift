//
//  Thread.swift
//  PullToRefresh
//
//  Created by Vinh on 15/06/2024.
//

import SwiftUI

struct ThreadOverlayIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.96761*width, y: 0.3275*height))
        path.addCurve(to: CGPoint(x: 0.87576*width, y: 0.16838*height), control1: CGPoint(x: 0.94804*width, y: 0.26576*height), control2: CGPoint(x: 0.9175*width, y: 0.21254*height))
        path.addCurve(to: CGPoint(x: 0.50837*width, y: 0.03209*height), control1: CGPoint(x: 0.7912*width, y: 0.07886*height), control2: CGPoint(x: 0.66761*width, y: 0.03302*height))
        path.addLine(to: CGPoint(x: 0.50772*width, y: 0.03209*height))
        path.addCurve(to: CGPoint(x: 0.14446*width, y: 0.16885*height), control1: CGPoint(x: 0.3488*width, y: 0.03302*height), control2: CGPoint(x: 0.22652*width, y: 0.07905*height))
        path.addCurve(to: CGPoint(x: 0.03239*width, y: 0.49944*height), control1: CGPoint(x: 0.07141*width, y: 0.24883*height), control2: CGPoint(x: 0.0337*width, y: 0.36006*height))
        path.addLine(to: CGPoint(x: 0.03239*width, y: 0.49981*height))
        path.addLine(to: CGPoint(x: 0.03239*width, y: 0.50009*height))
        path.addCurve(to: CGPoint(x: 0.14446*width, y: 0.83068*height), control1: CGPoint(x: 0.0337*width, y: 0.63957*height), control2: CGPoint(x: 0.07141*width, y: 0.7508*height))
        path.addCurve(to: CGPoint(x: 0.50772*width, y: 0.96754*height), control1: CGPoint(x: 0.22652*width, y: 0.92049*height), control2: CGPoint(x: 0.3488*width, y: 0.96651*height))
        path.addLine(to: CGPoint(x: 0.50837*width, y: 0.96754*height))
        path.addCurve(to: CGPoint(x: 0.8313*width, y: 0.86427*height), control1: CGPoint(x: 0.64967*width, y: 0.9667*height), control2: CGPoint(x: 0.74924*width, y: 0.9348*height))
        path.addCurve(to: CGPoint(x: 0.90011*width, y: 0.58522*height), control1: CGPoint(x: 0.9387*width, y: 0.77194*height), control2: CGPoint(x: 0.93543*width, y: 0.65622*height))
        path.addCurve(to: CGPoint(x: 0.76011*width, y: 0.46558*height), control1: CGPoint(x: 0.87467*width, y: 0.53433*height), control2: CGPoint(x: 0.8263*width, y: 0.49289*height))
        path.addCurve(to: CGPoint(x: 0.75239*width, y: 0.46258*height), control1: CGPoint(x: 0.75761*width, y: 0.46455*height), control2: CGPoint(x: 0.7525*width, y: 0.46258*height))
        path.addCurve(to: CGPoint(x: 0.70978*width, y: 0.44808*height), control1: CGPoint(x: 0.7387*width, y: 0.45594*height), control2: CGPoint(x: 0.70989*width, y: 0.44808*height))
        path.addCurve(to: CGPoint(x: 0.64848*width, y: 0.43573*height), control1: CGPoint(x: 0.69674*width, y: 0.44425*height), control2: CGPoint(x: 0.68359*width, y: 0.44135*height))
        path.addCurve(to: CGPoint(x: 0.51446*width, y: 0.43022*height), control1: CGPoint(x: 0.60707*width, y: 0.42975*height), control2: CGPoint(x: 0.56228*width, y: 0.42788*height))
        path.addCurve(to: CGPoint(x: 0.2987*width, y: 0.5986*height), control1: CGPoint(x: 0.37957*width, y: 0.43686*height), control2: CGPoint(x: 0.29293*width, y: 0.50458*height))
        path.addCurve(to: CGPoint(x: 0.37652*width, y: 0.71422*height), control1: CGPoint(x: 0.30163*width, y: 0.6463*height), control2: CGPoint(x: 0.32935*width, y: 0.68737*height))
        path.addCurve(to: CGPoint(x: 0.5212*width, y: 0.74546*height), control1: CGPoint(x: 0.41641*width, y: 0.73686*height), control2: CGPoint(x: 0.46772*width, y: 0.74799*height))
        path.addCurve(to: CGPoint(x: 0.68565*width, y: 0.67661*height), control1: CGPoint(x: 0.59174*width, y: 0.7421*height), control2: CGPoint(x: 0.64707*width, y: 0.71899*height))
        path.addCurve(to: CGPoint(x: 0.74348*width, y: 0.54911*height), control1: CGPoint(x: 0.71489*width, y: 0.64443*height), control2: CGPoint(x: 0.73728*width, y: 0.60178*height))
        path.addCurve(to: CGPoint(x: 0.74674*width, y: 0.51263*height), control1: CGPoint(x: 0.7437*width, y: 0.5492*height), control2: CGPoint(x: 0.74641*width, y: 0.51693*height))
        path.addCurve(to: CGPoint(x: 0.74478*width, y: 0.44752*height), control1: CGPoint(x: 0.74913*width, y: 0.47717*height), control2: CGPoint(x: 0.74554*width, y: 0.45482*height))
        path.addCurve(to: CGPoint(x: 0.5112*width, y: 0.25005*height), control1: CGPoint(x: 0.73207*width, y: 0.32217*height), control2: CGPoint(x: 0.64848*width, y: 0.2508*height))
        path.addQuadCurve(to: CGPoint(x: 0.50924*width, y: 0.25005*height), control: CGPoint(x: 0.51022*width, y: 0.25005*height))
        path.addCurve(to: CGPoint(x: 0.31043*width, y: 0.33789*height), control1: CGPoint(x: 0.42435*width, y: 0.25005*height), control2: CGPoint(x: 0.3538*width, y: 0.2812*height))
        path.addCurve(to: CGPoint(x: 0.20826*width, y: 0.44724*height), control1: CGPoint(x: 0.31043*width, y: 0.33789*height), control2: CGPoint(x: 0.20837*width, y: 0.44715*height))
        path.addCurve(to: CGPoint(x: 0.16685*width, y: 0.53676*height), control1: CGPoint(x: 0.20815*width, y: 0.44724*height), control2: CGPoint(x: 0.16674*width, y: 0.53676*height))
        path.addCurve(to: CGPoint(x: 0.20609*width, y: 0.45229*height), control1: CGPoint(x: 0.16685*width, y: 0.53676*height), control2: CGPoint(x: 0.20609*width, y: 0.45229*height))
        path.addCurve(to: CGPoint(x: 0.16685*width, y: 0.53676*height), control1: CGPoint(x: 0.20609*width, y: 0.45229*height), control2: CGPoint(x: 0.16696*width, y: 0.53648*height))
        path.addCurve(to: CGPoint(x: 0.20576*width, y: 0.45295*height), control1: CGPoint(x: 0.16685*width, y: 0.53676*height), control2: CGPoint(x: 0.20587*width, y: 0.45295*height))
        return path
    }
}
