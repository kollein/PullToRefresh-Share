//
//  Today.swift
//  PullToRefresh
//
//  Created by Vinh on 23/06/2024.
//

import SwiftUI

// MARK: Data Model and Sample Data
struct Item: Identifiable{
    var id: String = UUID().uuidString
    var title: String
    var image: UIImage?
    var previewImage: UIImage?
    var appeared: Bool = false
}

var sampleItems: [Item] = [
    .init(title: "Logo1", image: UIImage(named: "Logo1")),
    .init(title: "Logo2", image: UIImage(named: "Logo2")),
    .init(title: "Logo1", image: UIImage(named: "Logo1")),
    .init(title: "Logo2", image: UIImage(named: "Logo2")),
    .init(title: "Logo1", image: UIImage(named: "Logo1")),
    .init(title: "Logo2", image: UIImage(named: "Logo2")),    .init(title: "Logo1", image: UIImage(named: "Logo1")),
    .init(title: "Logo2", image: UIImage(named: "Logo2")),    .init(title: "Logo1", image: UIImage(named: "Logo1")),
    .init(title: "Logo2", image: UIImage(named: "Logo2")),    .init(title: "Logo1", image: UIImage(named: "Logo1")),
    .init(title: "Logo2", image: UIImage(named: "Logo2")),    .init(title: "Logo1", image: UIImage(named: "Logo1")),
    .init(title: "Logo2", image: UIImage(named: "Logo2")),    .init(title: "Logo1", image: UIImage(named: "Logo1")),
    .init(title: "Logo2", image: UIImage(named: "Logo2")),
]
