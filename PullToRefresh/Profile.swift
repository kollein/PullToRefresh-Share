//
//  Profile.swift
//  PullToRefresh
//
//  Created by Vinh on 30/06/2024.
//

import SwiftUI

struct Profile: View {
    var body: some View {
        VStack {
            ScrollView {
                Spacer()
                    .frame(height: 20)
                
                Text("Hello profile view")
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}
