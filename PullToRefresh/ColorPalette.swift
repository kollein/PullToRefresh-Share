//
//  ColorPalette.swift
//  PullToRefresh
//
//  Created by Vinh on 29/06/2024.
//

import SwiftUI

struct ColorPalette: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Mode:")
                Text("Light")
                    .frame(width: 60, height: 40)
                Text("Dark")
                    .frame(width: 140, height: 40)
            }
            List(CC.colors, id: \.name) { color in
                HStack {
                    Text(color.name)
                        .frame(width: 150, alignment: .trailing)
                    Rectangle()
                        .environment(\.colorScheme, .light)
                        .frame(width: 75, height: 40)
                        .foregroundColor(color.color)
                        .border(Color.black, width: 3)
                    Rectangle()
                        .environment(\.colorScheme, .dark)
                        .frame(width: 75, height: 40)
                        .foregroundColor(color.color)
                        .border(Color.black, width: 3)
                    
                }
            }
        }
        .navigationTitle("Places")
    }
}

#Preview {
    ColorPalette()
}

struct CC {
    let name: String
    let color: Color
    
    static var colors: [CC] { [
        CC(name: "lightText", color: .lightText),
        CC(name: "darkText", color: .darkText),
        CC(name: "placeholderText", color: .placeholderText),
        CC(name: "label", color: .label),
        CC(name: "secondaryLabel", color: .secondaryLabel),
        CC(name: "tertiaryLabel", color: .tertiaryLabel),
        CC(name: "quaternaryLabel", color: .quaternaryLabel),
        CC(name: "systemBackground", color: .systemBackground),
        CC(name: "secondarySystemBackground", color: .secondarySystemBackground),
        CC(name: "tertiarySystemBackground", color: .tertiarySystemBackground),
        CC(name: "systemFill", color: .systemFill),
        CC(name: "secondarySystemFill", color: .secondarySystemFill),
        CC(name: "tertiarySystemFill", color: .tertiarySystemFill),
        CC(name: "quaternarySystemFill", color: .quaternarySystemFill),
        CC(name: "systemGroupedBackground", color: .systemGroupedBackground),
        CC(name: "secondarySystemGroupedBackground", color: .secondarySystemGroupedBackground),
        CC(name: "tertiarySystemGroupedBackground", color: .tertiarySystemGroupedBackground),
        CC(name: "systemGray", color: .systemGray),
        CC(name: "systemGray2", color: .systemGray2),
        CC(name: "systemGray3", color: .systemGray3),
        CC(name: "systemGray4", color: .systemGray4),
        CC(name: "systemGray5", color: .systemGray5),
        CC(name: "systemGray6", color: .systemGray6),
        CC(name: "separator", color: .separator),
        CC(name: "opaqueSeparator", color: .opaqueSeparator),
        CC(name: "link", color: .link),
        CC(name: "systemRed", color: .systemRed),
        CC(name: "systemBlue", color: .systemBlue),
        CC(name: "systemPink", color: .systemPink),
        CC(name: "systemTeal", color: .systemTeal),
        CC(name: "systemGreen", color: .systemGreen),
        CC(name: "systemIndigo", color: .systemIndigo),
        CC(name: "systemOrange", color: .systemOrange),
        CC(name: "systemPurple", color: .systemPurple),
        CC(name: "systemYellow", color: .systemYellow)]
    }
}
