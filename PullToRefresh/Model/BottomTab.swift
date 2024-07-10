//
//  Today.swift
//  PullToRefresh
//
//  Created by Vinh on 23/06/2024.
//

import SwiftUI

struct BottomTab: Identifiable{
    var id: String
    var title: String
    var image: String
    var imageFill: String
}

var bottomTabItems: [BottomTab] = [
    .init(id: "home", title: "Home", image: "dollarsign.circle", imageFill: "dollarsign.circle.fill"),
    .init(id: "stack", title: "Stack", image: "square.stack.3d.up", imageFill: "square.stack.3d.up.fill"),
    .init(id: "profile", title: "Profile", image: "person.circle", imageFill: "person.circle.fill")
]
