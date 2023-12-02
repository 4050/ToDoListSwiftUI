//
//  SwipeAction.swift
//  ToDoList
//
//  Created by Станислав on 25.11.2023.
//

import Foundation
import SwiftUI

struct SwipeAction<Content: View>: View {
    var cornerRadius: CGFloat = 0
    var direction: SwipeDirection = .trailing
    var shape: Shape = .rect
    @ViewBuilder var content: Content
    @ActionBuilder var actions: [Action]
    @State private var isEnabled: Bool = true
    var viewID = UUID()
    
    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    content
                        .containerRelativeFrame(.horizontal)
                        .background {
                            if actions.last != nil {
                                Circle()
                                    .fill(.clear)
                            }
                        }
                        .id(viewID)
                    ActionButtons {
                        withAnimation(.snappy) {
                            scrollProxy.scrollTo(viewID, anchor: direction == .trailing ? .topLeading : .topTrailing)
                        }
                    }
                }
                .scrollTargetLayout()
                .visualEffect { content, geometryProxy in
                    content
                        .offset(x: scrollOffset(geometryProxy))
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
        .allowsHitTesting(isEnabled)
    }
    
    @ViewBuilder
    func ActionButtons(resetPosition: @escaping () -> ()) -> some View {
        switch shape {
        case .cicle:
            Circle()
                .fill(.clear)
                .frame(width: 120)
                .overlay {
                    HStack(spacing: 10) {
                        ForEach(actions) { button in
                            Button(action: {
                                Task {
                                    isEnabled = false
                                    resetPosition()
                                    try? await Task.sleep(for: .seconds(0.25))
                                    button.action()
                                    try? await Task.sleep(for: .seconds(0.1))
                                    isEnabled = true
                                }
                            }, label: {
                                Image(systemName: button.icon)
                                    .font(button.iconFont)
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50) // Adjust the size of the circle as needed
                            })
                            .buttonStyle(.plain)
                            .background(Circle().fill(button.tint))
                        }
                    }
                }
        case .rect:
            Rectangle()
                .fill(.clear)
                .frame(width: CGFloat(actions.count) * 100)
                .overlay(alignment: direction.alignment) {
                    HStack(spacing: 0) {
                        ForEach(actions) { button in
                            Button(action: {
                                Task {
                                    isEnabled = false
                                    resetPosition()
                                    try? await Task.sleep(for: .seconds(0.25))
                                    button.action()
                                    try? await Task.sleep(for: .seconds(0.1))
                                    isEnabled = true
                                }
                            }, label: {
                                Image(systemName: button.icon)
                                    .font(button.iconFont)
                                    .foregroundColor(button.iconTint)
                                    .frame(width: 100)
                                    .frame(maxHeight: .infinity)
                            })
                            .buttonStyle(.plain)
                            .background(button.tint)
                        }
                    }
                }
        }
    }
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        
        return direction == .trailing ? (minX > 0 ? -minX: 0) : (minX < 0 ? -minX: 0)
    }
}

enum Shape {
    case cicle
    case rect
}

enum SwipeDirection {
    case leading
    case trailing
    
    var alignment: Alignment {
        switch self {
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        }
    }
}

struct Action: Identifiable {
    private(set) var id: UUID = .init()
    var tint: Color
    var icon: String
    var iconFont: Font = .title
    var iconTint: Color = .white
    var isEnabled: Bool = true
    let action: () -> ()
}

@resultBuilder
struct ActionBuilder {
    static func buildBlock(_ actions: Action...) -> [Action] {
        return actions
    }
}
