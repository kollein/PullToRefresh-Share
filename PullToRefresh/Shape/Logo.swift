//
//  Thread.swift
//  PullToRefresh
//
//  Created by Vinh on 15/06/2024.
//

import SwiftUI

struct LogoIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.22727*width, y: 0.90464*height))
        path.addLine(to: CGPoint(x: 0.2154*width, y: 0.93428*height))
        path.addCurve(to: CGPoint(x: 0.12803*width, y: height), control1: CGPoint(x: 0.2154*width, y: 0.93428*height), control2: CGPoint(x: 0.17551*width, y: height))
        path.addCurve(to: CGPoint(x: 0.02172*width, y: 0.93144*height), control1: CGPoint(x: 0.07778*width, y: height), control2: CGPoint(x: 0.04495*width, y: 0.98144*height))
        path.addCurve(to: CGPoint(x: 0.04242*width, y: 0.06495*height), control1: CGPoint(x: -0.00404*width, y: 0.87603*height), control2: CGPoint(x: 0.02374*width, y: 0.09304*height))
        path.addCurve(to: CGPoint(x: 0.09697*width, y: 0.05954*height), control1: CGPoint(x: 0.05808*width, y: 0.04149*height), control2: CGPoint(x: 0.08081*width, y: 0.04897*height))
        path.addCurve(to: CGPoint(x: 0.54293*width, y: 0.37809*height), control1: CGPoint(x: 0.17323*width, y: 0.10902*height), control2: CGPoint(x: 0.53308*width, y: 0.37423*height))
        path.addCurve(to: CGPoint(x: 0.54444*width, y: 0.37784*height), control1: CGPoint(x: 0.54419*width, y: 0.37861*height), control2: CGPoint(x: 0.54444*width, y: 0.37784*height))
        path.addCurve(to: CGPoint(x: 0.9053*width, y: 0.07809*height), control1: CGPoint(x: 0.54444*width, y: 0.37784*height), control2: CGPoint(x: 0.88864*width, y: 0.08608*height))
        path.addCurve(to: CGPoint(x: 0.90859*width, y: 0.07655*height), control1: CGPoint(x: 0.90631*width, y: 0.07784*height), control2: CGPoint(x: 0.90682*width, y: 0.07706*height))
        path.addCurve(to: CGPoint(x: 0.97197*width, y: 0.10954*height), control1: CGPoint(x: 0.96061*width, y: 0.06263*height), control2: CGPoint(x: 0.97197*width, y: 0.10954*height))
        path.addCurve(to: CGPoint(x: 0.98485*width, y: 0.93789*height), control1: CGPoint(x: 0.97197*width, y: 0.10954*height), control2: CGPoint(x: 1.00581*width, y: 0.86366*height))
        path.addCurve(to: CGPoint(x: 0.89672*width, y: height), control1: CGPoint(x: 0.98485*width, y: 0.93789*height), control2: CGPoint(x: 0.9697*width, y: 0.99381*height))
        path.addCurve(to: CGPoint(x: 0.80202*width, y: 0.94613*height), control1: CGPoint(x: 0.88131*width, y: 1.00129*height), control2: CGPoint(x: 0.82298*width, y: 0.99845*height))
        path.addCurve(to: CGPoint(x: 0.78157*width, y: 0.77139*height), control1: CGPoint(x: 0.79167*width, y: 0.91959*height), control2: CGPoint(x: 0.78586*width, y: 0.88299*height))
        path.addCurve(to: CGPoint(x: 0.7846*width, y: 0.47603*height), control1: CGPoint(x: 0.77753*width, y: 0.66314*height), control2: CGPoint(x: 0.7851*width, y: 0.47964*height))
        path.addCurve(to: CGPoint(x: 0.75328*width, y: 0.46546*height), control1: CGPoint(x: 0.78258*width, y: 0.45747*height), control2: CGPoint(x: 0.76313*width, y: 0.45851*height))
        path.addCurve(to: CGPoint(x: 0.50833*width, y: 0.68325*height), control1: CGPoint(x: 0.74217*width, y: 0.4732*height), control2: CGPoint(x: 0.59646*width, y: 0.60309*height))
        path.addCurve(to: CGPoint(x: 0.47146*width, y: 0.73067*height), control1: CGPoint(x: 0.49722*width, y: 0.69356*height), control2: CGPoint(x: 0.47626*width, y: 0.70954*height))
        path.addCurve(to: CGPoint(x: 0.55076*width, y: 0.82732*height), control1: CGPoint(x: 0.46818*width, y: 0.7451*height), control2: CGPoint(x: 0.47475*width, y: 0.82397*height))
        path.addCurve(to: CGPoint(x: 0.63308*width, y: 0.72448*height), control1: CGPoint(x: 0.61641*width, y: 0.8299*height), control2: CGPoint(x: 0.64848*width, y: 0.76675*height))
        path.addCurve(to: CGPoint(x: 0.46944*width, y: 0.61521*height), control1: CGPoint(x: 0.61843*width, y: 0.68454*height), control2: CGPoint(x: 0.52803*width, y: 0.62577*height))
        path.addCurve(to: CGPoint(x: 0.3404*width, y: 0.63247*height), control1: CGPoint(x: 0.41086*width, y: 0.60464*height), control2: CGPoint(x: 0.3404*width, y: 0.63247*height))
        return path
    }
}
