//
//  CustomRefreshableView.swift
//  PullToRefresh
//
//  Created by Vinh on 15/06/2024.
//

import SwiftUI

struct CustomRefreshableSearchableView<Content: View>: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var overlayStore: OverlayStore
    
    var content: Content
    var showIndicator: Bool
    var onRefresh: ()async->()
    
    let iconHeight: CGFloat = 32
    let iconCompensatedHeight: CGFloat = 32
    let iconWidth: CGFloat = 32.8888888889
    let lineWidth: CGFloat = 3.2
    let lineWidthOverlay: CGFloat = 4.2
    let bubblingLogoAnimDuration: CGFloat = 0.12
    let revertingStrokeAnimDuration: CGFloat = 1
    let strokeRunningLength: CGFloat = 0.086
    let strokeRunningMinOpacity: CGFloat = 0.2
    
    @StateObject private var scrollDelegate: SearchableScrollViewModel = .init()
    @State private var strokeEnd: CGFloat = 0
    @State private var strokeStart: CGFloat = 0
    @State private var isBubblingLogo: Bool = false
    @State private var isBubblingLogoEnded: Bool = true
    @State private var isRunningStroke: Bool = false
    @State private var runningMode: String = "ended" // "backward" | "forward" | "backwardOfEnd" | "ended"
    
    @State private var isTriggeredHapticFeedback: Bool = false
    @State private var actualEndedRefreshAction: Bool = true
    
    init(showIndicator: Bool = false, @ViewBuilder content: @escaping () -> Content, onRefresh: @escaping ()async->()){
        self.showIndicator = showIndicator
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: showIndicator) {
                
                VStack(spacing: 0) {
                    // Mark: Main Content
                    VStack(alignment: .leading) {
                        content
                    }
                }
                .offsetPTR(coordinateSpace: "SCROLL_HOME_VIEW") { offset in
//                    print("offset", offset)
                    // Mark: Storing Scroll Offset
                    store.scrollOffset = offset
                    scrollDelegate.scrollOffset = offset
                    
                    // Logo Scrollup Progress
                    overlayStore.homeLogoScrollupProgress = scrollDelegate.scrollOffset >= 0 ? 1 : scrollDelegate.scrollOffset / -iconCompensatedHeight >= 1 ? 0 : Double(exactly: (1 - (scrollDelegate.scrollOffset / -iconCompensatedHeight)))!
                    
                    // Mark: Reset Haptic Feedback
                    if offset <= 0 {
//                        print("Released offset event: ", runningMode)
                        isTriggeredHapticFeedback = false
                    }
                    
                    if scrollDelegate.isEligible && !scrollDelegate.isRefreshing {
                        print("offset:isEligible", scrollDelegate.isEligible, "set:isRefreshing=true")
                        scrollDelegate.isRefreshing = true
                        isTriggeredHapticFeedback = false
                        actualEndedRefreshAction = false
                    }
                }
            }
            .coordinateSpace(name: "SCROLL_HOME_VIEW")
            .onAppear(perform: scrollDelegate.addGesture)
            .onDisappear(perform: scrollDelegate.removeGesture)
            .onChange(of: scrollDelegate.isRefreshing) {
                if scrollDelegate.isRefreshing {
                    Task{
//                        print("onChange:onRefresh:start")
                        await onRefresh()
//                        print("onChange:onRefresh:end", scrollDelegate.progress)
                        
                        scrollDelegate.isEligible = false
                        scrollDelegate.isRefreshing = false
                        isBubblingLogo = false
                        actualEndedRefreshAction = true
//                        print("onChange", "set:isEligible=false:isRefreshing=false")
                    }
                }
            }
    }
    
    // Mark: Logo
    func ThreadLogo()->some View {
        // Mark: Stroke Styling
        @State var mainOpacity: CGFloat = isRunningStroke ? strokeRunningMinOpacity : runningMode == "ended" && scrollDelegate.progress >= 1 && isBubblingLogoEnded ? 1 : (1 - scrollDelegate.progress * 2.6 < strokeRunningMinOpacity ? strokeRunningMinOpacity : 1 - scrollDelegate.progress * 2.6)
        
        @State var toStroke: CGFloat = isRunningStroke && runningMode != "backwardOfEnd" ? (runningMode == "forward" ? 1 - 0.08 + strokeRunningLength : -0.025) : strokeEnd
        @State var fromStroke: CGFloat = isRunningStroke && runningMode != "backwardOfEnd" ? (runningMode == "forward" ? 1 - 0.08 : -0.025 - strokeRunningLength) : strokeStart

        var body: some View {
            ZStack(alignment: .top) {
                ThreadIcon()
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt, lineJoin: .miter))
                    .frame(width: iconWidth, height: iconHeight)
                    .foregroundColor(.black)
                    .opacity(mainOpacity)
                
                
                ThreadIcon()
                    .trim(from: fromStroke, to: toStroke)
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .miter))
                    .frame(width: iconWidth, height: iconHeight)
                    .foregroundColor(.black)
            }
            .frame(height: iconCompensatedHeight)
            .scaleEffect(isBubblingLogo ? 1.32 : 1, anchor: .center)
        }
        
        return body
    }
}

// Mark: Simultaneously Pan Gesture
class SearchableScrollViewModel: NSObject, ObservableObject, UIGestureRecognizerDelegate {
    let gestureID = "refreshableSearchable-gestureId"
    @Published var pullThreshold: CGFloat = 90.0
    @Published var isEligible: Bool = false
    @Published var isRefreshing: Bool = false
    @Published var scrollOffset: CGFloat = 0
    @Published var progress: CGFloat = 0
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // Mark: Adding Gesture
    func addGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(onGestureChange(gesture:)))
        panGesture.delegate = self
        panGesture.name = gestureID

        rootController().view.addGestureRecognizer(panGesture)
    }
    
    // Mark: Remove When Leaving the view
    func removeGesture() {
        rootController().view.gestureRecognizers?.removeAll(where: { gesture in
            gesture.name == gestureID
        })
    }
    
    
    // Mark: Finding Root Controller
    func rootController()-> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else{
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else{
            return .init()
        }
        
        return root
    }
    
    @objc
    func onGestureChange(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
//            print("Start touch:isRefreshing", isRefreshing)
        }
        
        if gesture.state == .cancelled || gesture.state == .ended {
//            print("Released touch")
            // Mark: Pull To Threshold
            if !isRefreshing {
                if scrollOffset > pullThreshold {
                    isEligible = true
//                    print("onGestureChange:isRefreshing=false:scrollOffset > pullThreshold ", "set:isEligible=true")
                } else {
                    isEligible = false
//                    print("onGestureChange:isRefreshing=false:scrollOffset > pullThreshold ", "set:isEligible=false")
                }
            }
        }
    }
}
