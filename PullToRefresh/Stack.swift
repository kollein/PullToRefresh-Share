//
//  Stack.swift
//  PullToRefresh
//
//  Created by Vinh on 30/06/2024.
//

import SwiftUI
import SwiftUIIntrospect

struct Stack: View {
    @EnvironmentObject var store: Store
    @State private var username: String = ""
    
    @State private var showSearchRecentOverlay: Bool = false
    @State private var showSearchRecentSuggestion: Bool = false
    @FocusState private var emailFieldIsFocused: Bool
    // Logo Icon
    let iconHeight: CGFloat = 32
    let iconWidth: CGFloat = 32
    let lineWidth: CGFloat = 1
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = navBarAppearance
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                            Text("Tìm kiếm gần đây")
                                .font(.system(size: 15, weight: .semibold, design: .default))
                                .foregroundStyle(Color.secondaryLabel)
                            
                            Spacer()
                            
                            NavigationLink {
                                Text("link detail")
                                    .toolbar {
                                        ToolbarItem(placement: .principal) {
                                            Text("Chỉnh sửa lịch sử tìm kiếm")
                                                .fontWeight(.semibold)
                                        }
                                        
                                        // Hide the label "Back"
                                        ToolbarItem(placement: .topBarLeading) {
                                            Color.clear
                                        }
                                    }
                            } label: {
                                Text("Chỉnh sửa")
                                    .font(.system(size: 15, weight: .semibold, design: .default))
                                    .foregroundStyle(Color.systemBlue)
                            }
                        }
                        .padding(.top, 16)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 1), spacing: 0) {
                            ForEach(1...20, id: \.self) { id in
                                VStack {
                                    Text("Click search: " + id.description)
                                        .frame(height: 46)
                                        .onTapGesture {
                                            print("Click search: ", id)
                                        }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .background(Color.white)
                .zIndex(store.isPresented ? 1 : 0)
                
                ScrollView {
                    Text("scrollOffset: " + round(store.scrollOffset).description)
                    
                    Color
                        .blue
                        .frame(height: 46)
                    
                    Text("Hello stack view:isPresented: " + store.isPresented.description)
                        .foregroundColor(Color.green)
                    
                    Color
                        .green
                        .frame(height: 46)
                    
                    Text(username)
                        .foregroundColor(emailFieldIsFocused ? .red : .blue)
                    
                    Rectangle()
                        .fill(Color.secondarySystemBackground)
                        .frame(height: 1400)
                }
                .background(Color.white)
                .zIndex(0)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    //                    LogoIcon()
                    MarketplaceIcon()
                        .trim(from: 0, to: 1)
                        .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt, lineJoin: .miter))
                        .frame(width: iconWidth, height: iconHeight)
                        .foregroundColor(Color.primary)
                        .offset(y: -1.8) // Fix iphone 14 Pro Max
                }
            }
            .searchable(
                text: $username,
                isPresented: $store.isPresented,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Tìm kiếm"
            )
            .autocorrectionDisabled(true)
            .keyboardType(.alphabet)
            .onChange(of: store.isPresented) {
                withAnimation(.easeInOut(duration: store.isPresented ? 0.3 : 0.26)) {
                    showSearchRecentOverlay = store.isPresented
                }
                
                withAnimation(.spring(duration: store.isPresented ? 0.6 : 0.26)) {
                    showSearchRecentSuggestion = store.isPresented
                }
            }
        }
        .introspect(.searchField , on: .iOS(.v17)) { searchField in
            // set background/tint color
            searchField.searchTextField.backgroundColor = Color.gray7
            searchField.searchTextField.tintColor = UIColor.systemBlue
            
            // removing the border style also removes the `tertiarySystemFillColor`
            searchField.searchTextField.borderStyle = .none
            
            // but removing the border style also removes the corner radius, so we have to apply it back
            searchField.searchTextField.layer.cornerRadius = 10
        }
    }
}
