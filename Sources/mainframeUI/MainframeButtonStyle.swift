//
//  MainframeButtonStyle.swift
//  mainframeUI
//
//  Created by Tomas Martins on 19/10/24.
//

import SwiftUI

public struct MainframeButtonStyle: ButtonStyle {
    private let borderWidth: CGFloat = 4
    private let pressedScale: CGFloat = 0.96
    private let shadowRadius: CGFloat = 1
    private let shadowYOffset: CGFloat = 2
    private let pressedOpacity: CGFloat = 0.1
    private let animationDuration: CGFloat = 0.2
    private let innerCapsuleScaleEffect: CGFloat = 0.92
    
    private let borderGradientColors: [Color] = [
        .white.opacity(0.8),
        .black.opacity(0.4),
        .white.opacity(0.5)
    ]
    
    private let shadowBorderColors: [Color] = [
        .black,
        .black.opacity(0.8),
        .black.opacity(0.1)
    ]
    
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .fontWeight(.semibold)
            .padding()
            .background(
                ZStack {
                    Capsule()
                        .fill(.foreground)
                        .fill(borderGradient)
                    Capsule()
                        .fill(.foreground)
                        .scaleEffect(innerCapsuleScaleEffect)
                }
            )
            .overlay {
                shadowBorder(configuration.isPressed)
            }
            .compositingGroup()
            .shadow(
                color: .black.opacity(configuration.isPressed ? 0.0 : 0.5),
                radius: shadowRadius,
                y: shadowYOffset
            )
            .overlay {
                if configuration.isPressed {
                    Capsule().fill(.black).opacity(pressedOpacity)
                }
            }
            .scaleEffect(configuration.isPressed ? pressedScale : 1.0)
            .animation(.smooth(duration: animationDuration), value: configuration.isPressed)
    }
    
    private var borderGradient: LinearGradient {
        LinearGradient(
            colors: borderGradientColors,
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private func shadowBorder(_ isPressed: Bool) -> some View {
        Capsule()
            .stroke(
                LinearGradient(
                    colors: shadowBorderColors,
                    startPoint: .top,
                    endPoint: .bottom
                ),
                lineWidth: isPressed ? 2 : 1
            )
    }
}

extension ButtonStyle where Self == MainframeButtonStyle {
    public static var mainframe: MainframeButtonStyle {
        MainframeButtonStyle()
    }
}

#Preview {
    ZStack {
        Color(red: 0.92, green: 0.92, blue: 0.92)
            .ignoresSafeArea()
        Button {
            
        } label: {
            Text("Primary")
                .padding(.horizontal)
        }
        .buttonStyle(.mainframe)
        .foregroundStyle(.gray.gradient)
    }
}
