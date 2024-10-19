//
//  SwiftUIView.swift
//  mainframeUI
//
//  Created by Tomas Martins on 19/10/24.
//

import SwiftUI

public struct ShinyButtonStyle: ButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(
                .white
                    .gradient
                    .shadow(
                        .drop(
                            color: .black.opacity(0.4),
                            radius: 0,
                            y: -1
                        )
                    )
            )
            .fontWeight(.semibold)
            .padding()
            .background(
                ZStack {
                    Capsule()
                        .fill(.foreground)
                    Capsule()
                        .fill(.foreground)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    .white.opacity(0.6),
                                    .white.opacity(0.2),
                                    .black.opacity(0.6),
                                    .white.opacity(0.2),
                                    .white.opacity(0.4)
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            ),
                            lineWidth: 4
                        )
                        .padding(2)
                }
            )
            .overlay {
                Capsule()
                    .stroke(LinearGradient(
                        colors: [
                            .black,
                            .black.opacity(0.8),
                            .black.opacity(0.1)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ), lineWidth: 1)
            }
            .compositingGroup()
            .shadow(radius: 1, y: 2)
    }
}

extension ButtonStyle where Self == ShinyButtonStyle {
    public static var shiny: ShinyButtonStyle {
        ShinyButtonStyle()
    }
}

#Preview {
    ZStack {
        Color(red: 0.91, green: 0.89, blue: 0.87)
            .ignoresSafeArea()
        Button("\(Image(systemName: "sun.min.fill"))") {
            
        }
        .font(.largeTitle)
        .buttonStyle(.shiny)
        .foregroundStyle(.brown.gradient)
    }
}
