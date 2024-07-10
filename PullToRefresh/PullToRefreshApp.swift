//
//  PullToRefreshApp.swift
//  PullToRefresh
//
//  Created by Vinh on 15/06/2024.
//

import SwiftUI
import SwiftData

@main
struct PullToRefreshApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let modelContainer: ModelContainer
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Settings.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    // Init Global Stores
    @StateObject var store = Store()
    @StateObject var overlayStore = OverlayStore()
    @StateObject var coordinator = UICoordinator()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                
                GeometryReader { reader in
                    Color(store.selectedTabId == "home" ? .white.withAlphaComponent(overlayStore.getSafeAreaOpacity(coordinator.animateView)) : .clear)
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .ignoresSafeArea()
                }
            }
            // Light Mode Only
            .preferredColorScheme(.light)
            .environmentObject(store)
            .environmentObject(overlayStore)
            .environmentObject(coordinator)
        }
        .modelContainer(modelContainer)
    }
}

