//
//  CustomDraggableView.swift
//  PullToRefresh
//
//  Created by Vinh on 19/06/2024.
//

import SwiftUI

let logger: Logger = .init(id: "C", section: "g")

struct CustomDraggableView<Content: View>: View {
    var content: Content
    var showIndicator: Bool = false
    @StateObject var scrollDelegate: DraggableScrollViewModel = .init()
    @EnvironmentObject var coordinator: UICoordinator
    let headerBarHeight: CGFloat = 46
    
    init(showIndicator: Bool = false, @ViewBuilder content: @escaping () -> Content){
        self.showIndicator = showIndicator
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            // Overlay On Dragging
            Rectangle()
                .fill(Color.white)
                .ignoresSafeArea(edges: .bottom)
                .opacity(scrollDelegate.isDragging ? scrollDelegate.backgroundAlpha : 0)
            
            ScrollView(.vertical, showsIndicators: showIndicator) {
                
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        // Compensate For Header Bar
                        Spacer()
                            .frame(height: headerBarHeight)
                        
                        // Main Image
                        content
                            .opacity(coordinator.showDetailView ? 1 : 0)
                        
                        // Content
                        VStack{
                            
                            Text("scrollDelegate.isTouching" + ": " + scrollDelegate.isTouching.description)
                            Text("scrollDelegate.isDragging" + ": " + scrollDelegate.isDragging.description)
                            
                            Button {
                                logger.log(message: "Clicked!")
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Click Me Now:")
                                }
                                .background(.cyan)
                                HStack {
                                    Text(verbatim: "\(scrollDelegate.scrollOffset.rounded())")//.lineLimit(1)
                                    Spacer()
                                }
                                .background(.green)
                            }
                            .padding(.top, 40)
                            
                            Rectangle()
                                .fill(Color.secondarySystemBackground)
                                .frame(height: 700)
                        }
//                        .opacity(coordinator.animateView ? 1 : 0)
                        // Keep The ScrollView Is Always At Top (Content)
                        .offset(y: scrollDelegate.isDragging ? 0 : scrollDelegate.scrollOffset > 0 ? scrollDelegate.scrollOffset : 0)
                    }
                    // Keep The ScrollView Is Always At Top (Image)
                    .offset(y: scrollDelegate.isDragging ? 0 : scrollDelegate.scrollOffset > 0 ? -scrollDelegate.scrollOffset : 0)
                    .offsetOverlay(coordinateSpace: "SCROLL_OVERLAY", isDragging: scrollDelegate.isDragging) { offset in
                        // Mark: Storing Scroll Offset
                        scrollDelegate.scrollOffset = offset
                    }
                    
                }
            }
            .overlay(alignment: .top) {
                // Header Bar
                Rectangle()
                    .fill(Color.white)
                    .frame(height: headerBarHeight)
                    .border(width: 0.25, edges: [.bottom], color: Color.separator)
                    .overlay(alignment: .topLeading) {
                        HStack {
                            Button {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                coordinator.toogleView(show: false)
                            } label: {
                                Image(systemName: "multiply")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 18)
                                    .foregroundColor(.primary)
                            }

                            Spacer()
                            
                            Button {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                coordinator.toogleView(show: false)
                            } label: {
                                Image(systemName: "heart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                            }
                        }
                        .padding(.top, 14)
                        .padding(.horizontal, 16)
                    }
            }
            .coordinateSpace(name: "SCROLL_OVERLAY")
            .onAppear(perform: scrollDelegate.addGesture)
            .onDisappear(perform: scrollDelegate.removeGesture)
            .onChange(of: scrollDelegate.isEligible) {
                if scrollDelegate.isEligible {
                    coordinator.detailViewScrollOffset = scrollDelegate.scrollOffset
                    coordinator.toogleView(show: false)
                }
            }
            .background(Color.white)
            .cornerRadius(scrollDelegate.isTouching && scrollDelegate.isDragging ? 12 : 0)
            .shadow(color: Color(.black.withAlphaComponent(scrollDelegate.isTouching && scrollDelegate.isDragging ? 0.16 : 0)), radius: 8)
            .opacity(coordinator.showDetailViewNoDelay ? (coordinator.animateView ? 1 : 0) : 0
            )
            .scaleEffect(scrollDelegate.scaleOnDraggingDown)
            .disabled(scrollDelegate.isDragging ? true : false)
            // MarK: Update The View Offset By Pan Gesture Translation
            .offset(x: scrollDelegate.viewTranslation.width, y: scrollDelegate.viewTranslation.height)
            
        }
    }
}

// Mark: Simultaneously Pan Gesture
class DraggableScrollViewModel: NSObject, ObservableObject, UIGestureRecognizerDelegate {
    let gestureID = UUID().uuidString
    @Published var isTouching: Bool = false
    @Published var isEligible: Bool = false
    @Published var scrollOffset: CGFloat = 0
    // Mark: Direction
    let movingBackAnimDuration: CGFloat = 0.26
    @Published var isVertical: Bool = false
    enum UIPanGestureRecognizerDirection {
        case undefined
        case bottomToTop
        case topToBottom
        case rightToLeft
        case leftToRight
    }
    @Published var direction: UIPanGestureRecognizerDirection = .undefined
    
    @Published var velocity: CGPoint = CGPoint.zero
    @Published var viewUIKitTranslation: CGPoint = CGPoint.zero
    @Published var viewTranslation: CGSize = CGSize.zero
    @Published var isDragging = false
    @Published var horizontalDistance: CGFloat = 0
    @Published var horizontalDistanceThreshold: CGFloat = 40
    @Published var verticalDistance: CGFloat = 0
    @Published var verticalDistanceThreshold: CGFloat = 60
    @Published var isReachedHorizontalThreshold: Bool = false
    @Published var isReachedVerticalThreshold: Bool = false
    @Published var isReachedThreshold: Bool = false
    @Published var enableHorizontalHapticFeedback: Bool = true
    @Published var enableVerticalHapticFeedback: Bool = true
    @Published var enableHapticFeedback: Bool = true
    @Published var backgroundAlpha: CGFloat = 1
    var endedTimer: Timer = .init()
    
    let scaleThreshold: CGFloat = 0.96
    @Published var scaleOnDraggingDown: CGFloat = 1
    
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
            isTouching = true
            isEligible = false
            isDragging = false
            isVertical = false
            direction = .undefined
            logger.log(message: "onGestureChange:Started touch:isTouching: " + isTouching.description + ":scrollOffset:" + scrollOffset.description)
            
        }
        
        if gesture.state == .changed {
            logger.log(message: "onGestureChange:.changed:scrollOffset: " + scrollOffset.description + ":isDragging:" + isDragging.description)
            velocity = gesture.velocity(in: gesture.view)
            viewUIKitTranslation = gesture.translation(in: gesture.view)
            
            if abs(velocity.y) > abs(velocity.x) && !isDragging {
                isVertical = true
            }
            
            if isVertical {
                direction = velocity.y > 0 ? .topToBottom : .bottomToTop
            } else {
                direction = velocity.x > 0 ? .leftToRight : .rightToLeft
            }
            
            logger.log(message: "gesture went: " + "\(direction)")
            
            if isVertical && !isDragging {
                var allowDragEvent: Bool = false
                
                if direction == .topToBottom && scrollOffset >= 0 && scrollOffset <= verticalDistanceThreshold {
                    allowDragEvent = true
                }
                
                if !allowDragEvent {
                    viewTranslation = .zero
                    logger.log(message: "Should scrolling...!")
                    return
                }
            }
            
            horizontalDistance = abs(viewUIKitTranslation.x)
            verticalDistance = abs(viewUIKitTranslation.y)
            //            logger.log(message: "onGestureChange:.changed:", horizontalDistance, verticalDistance)
            
            viewTranslation = CGSize(width: viewUIKitTranslation.x, height: viewUIKitTranslation.y)
            isDragging = true
            
            isReachedHorizontalThreshold = horizontalDistance >= horizontalDistanceThreshold
            isReachedVerticalThreshold = verticalDistance >= verticalDistanceThreshold
            isReachedThreshold = isReachedHorizontalThreshold || isReachedVerticalThreshold ? true : false
            
            // Mark: Not Reached Threshold Then Enable Haptic Feedback
            if !isReachedHorizontalThreshold {
                enableHorizontalHapticFeedback = true
            }
            if !isReachedVerticalThreshold {
                enableVerticalHapticFeedback = true
            }
            
            // Mark: Reached Threshold Then Disable Haptic Feedback
            if isReachedHorizontalThreshold && enableHorizontalHapticFeedback == true {
                enableHorizontalHapticFeedback = false
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
            if isReachedVerticalThreshold && enableVerticalHapticFeedback == true {
                enableVerticalHapticFeedback = false
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
            
            let horizontalBackgroundAlpha = horizontalDistance / (horizontalDistanceThreshold * 2) >= 1 ? 0 : 1 - horizontalDistance / (horizontalDistanceThreshold * 2)
            let verticalBackgroundAlpha = verticalDistance / (verticalDistanceThreshold * 2) >= 1 ? 0 : 1 - verticalDistance / (verticalDistanceThreshold * 2)
            backgroundAlpha = horizontalBackgroundAlpha >= verticalBackgroundAlpha ? verticalBackgroundAlpha : horizontalBackgroundAlpha
            
            let scalePercent = verticalDistance / (verticalDistanceThreshold * 40)
            scaleOnDraggingDown = scalePercent >= 1 ? scaleThreshold : 1 - scalePercent <= scaleThreshold ? scaleThreshold : 1 - scalePercent
        }
        
        if gesture.state == .cancelled || gesture.state == .ended {
            isTouching = false
            logger.log(message: "onGestureChange:Released touch:isTouching: " + isTouching.description)
            direction = .undefined
            isVertical = false
            
            if (isReachedThreshold) {
                logger.log(message: "onGestureChange:cancelled|onEnded:close: " + horizontalDistance.description + verticalDistance.description)
                isEligible = true
                isDragging = false
                
            } else {
                withAnimation(.easeInOut(duration: movingBackAnimDuration)) {
                    viewTranslation = .zero
                    backgroundAlpha = 1
                    scaleOnDraggingDown = 1
                }

                // Cancel Previous Schedule If Exist
                endedTimer.invalidate()
                // Run New One
                endedTimer = Timer.scheduledTimer(withTimeInterval: movingBackAnimDuration, repeats: false) { _ in
                    // Completely Ended
                    self.isDragging = false
                }
            }
            
        }
    }
}
