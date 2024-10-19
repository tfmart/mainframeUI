//
//  MainframeButtonStyle.swift
//  mainframeUI
//
//  Created by Tomas Martins on 19/10/24.
//

import SwiftUI

public struct MainframeButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(labelForegroundStyle)
            .fontWeight(.semibold)
            .padding()
            .background(
                Capsule()
                    .fill(.foreground)
                    .stroke(
                        LinearGradient(
                            colors: borderGradientColors(configuration.isPressed),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 4
                    )
                    .padding(2)
            )
            .overlay {
                shadowBorder(configuration.isPressed)
            }
            .compositingGroup()
            .shadow(color: .black.opacity(configuration.isPressed ? 0.0 : 0.5), radius:  1, y: 2)
            .overlay {
                if configuration.isPressed {
                    Capsule().fill(.black).opacity(0.1)
                }
            }
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(pressedDownAnimation,
                       value: configuration.isPressed)
        
    }
    
    var labelForegroundStyle: some ShapeStyle {
        Color.white
            .gradient
            .shadow(
                .drop(
                    color: .black.opacity(0.4),
                    radius: 0,
                    y: -1
                )
            )
    }
    
    func shadowBorder(_ isPressed: Bool) -> some View {
        Capsule()
            .stroke(LinearGradient(
                colors: [
                    .black,
                    .black.opacity(0.8),
                    .black.opacity(0.1)
                ],
                startPoint: .top,
                endPoint: .bottom
            ), lineWidth: isPressed ? 2 : 1)
    }
    
    var pressedDownAnimation: Animation {
        .smooth(duration: 0.2)
    }
    
    func borderGradientColors(_ isPressed: Bool) -> [Color] {
        if isPressed {
            [
                .black.opacity(0.2),
                .black.opacity(0.8),
                .black.opacity(0.1)
            ]
        } else {
            [
                .white.opacity(0.8),
                .black.opacity(0.4),
                .white.opacity(0.5)
            ]
        }
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
