//
//  ContentView.swift
//  PullToRefresh
//
//  Created by Vinh on 15/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Settings.date, order: .reverse)], animation: .snappy) private var settingsList: [Settings]
    @State private var settings: Settings?
    
    @EnvironmentObject var store: Store
    @EnvironmentObject var overlayStore: OverlayStore
    @EnvironmentObject var coordinator: UICoordinator
    @State private var fadeOutBottomTabAnim: Bool = false
    
    // For Dectecting Application On Close
    @State private var notificationObserver: NSObjectProtocol = NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) {_ in}
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.shadowColor = .clear
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
    
    var body: some View {
        /**
         * TODO: investigate why Binding on TabView
         * causes the CustomDraggableView laggy issue
         * eg: TabView(selection: $store.selectedTabId) {
         */
        TabView {
            Home()
                .tabItem{
                    Label("Home", systemImage: "house")
                }
                .tag("home")
            
            Stack()
                .tabItem{
                    Label("2", systemImage: "house")
                }
                .tag("Stack")
            
            Profile()
                .tabItem{
                    Label("3", systemImage: "house")
                }
                .tag("Profile")
        }
        .onAppear{
            loadSettings()
        }
        
    }
    
    func loadSettings() {
        let request = FetchDescriptor<Settings>()
        let data = try? modelContext.fetch(request)
        if data?.last != nil {
            let newSettings = data!.last!
            settings = newSettings
            print("loadSettings: ", newSettings.lastSelectedBottomTab)
            store.selectBottomTab(newSettings.lastSelectedBottomTab)
        } else {
            settings = Settings(lastSelectedBottomTab: "home", date: Date())
            print("loadSettings: Null")
        }
        
        // Listen For Closing App
        notificationObserver = NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) { _ in
            saveSettings()
            if notificationObserver.description != "" {
                print("removeObserver: success")
                NotificationCenter.default.removeObserver(notificationObserver)
            }
        }
    }
    
    func saveSettings() {
        do {
            try modelContext.delete(model: Settings.self)
            let newSettings = Settings(lastSelectedBottomTab: store.selectedTabId, date: Date())
            modelContext.insert(newSettings)
            try modelContext.save()
            print("saveSettings: success")
        } catch {
            print("saveSettings: error")
        }
    }
}

