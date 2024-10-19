//
//  MainframeToggleStyle.swift
//  mainframeUI
//
//  Created by Tomas Martins on 19/10/24.
//

import SwiftUI

public struct MainframeToggleStyle: ToggleStyle {
    private let toggleWidth: CGFloat = 48
    
    private let thumbScaleFactor: CGFloat = 0.9
    private let innerShadowRadius: CGFloat = 3
    private let innerShadowYOffset: CGFloat = 2
    
    private var toggleHeight: CGFloat {
        toggleWidth / 1.5
    }
    
    private var cornerRadius: CGFloat {
        toggleWidth / 1.75
    }
    
    private var thumbSize: CGFloat {
        toggleWidth / 1.5
    }
    
    private var thumbOffset: CGFloat {
        toggleWidth / 5.6
    }
    
    private var borderWidth: CGFloat {
        toggleWidth / 8
    }
    
    private let thumbColor: Color = Color(red: 0.82, green: 0.85, blue: 0.79)
    private let onColor: Color = .green
    private let offColor: Color = .gray
    private let thumbLightColor: Color = Color(red: 0.67, green: 0.96, blue: 0.72)
    
    public func makeBody(configuration: Configuration) -> some View {
        LabeledContent {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(thumbColor
                        .shadow(.inner(color: .black.opacity(0.4), radius: innerShadowRadius, y: -innerShadowYOffset))
                        .shadow(.inner(color: .white.opacity(0.6), radius: innerShadowRadius, y: innerShadowYOffset)),
                            lineWidth: borderWidth)
                    .fill(configuration.isOn ? onColor.gradient : offColor.gradient)
                    .rotationEffect(.degrees(180))
                    .frame(width: toggleWidth, height: toggleHeight)
                    .overlay {
                        thumb(configuration.isOn)
                            .foregroundStyle(thumbColor.gradient)
                            .frame(width: thumbSize, height: thumbSize)
                            .offset(x: configuration.isOn ? thumbOffset : -thumbOffset)
                            .compositingGroup()
                            .shadow(radius: 8)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onEnded { value in
                                        let threshold = geometry.size.width / 2
                                        withAnimation {
                                            if value.translation.width > threshold {
                                                configuration.isOn = true
                                            } else if value.translation.width < -threshold {
                                                configuration.isOn = false
                                            } else {
                                                configuration.isOn.toggle()
                                            }
                                        }
                                    }
                            )
                    }
                    .animation(.easeOut, value: configuration.isOn)
                    .onTapGesture {
                        withAnimation {
                            configuration.isOn.toggle()
                        }
                    }
            }
            .frame(width: toggleWidth, height: toggleHeight)
        } label: {
            configuration.label
        }
    }
    
    func thumb(_ isOn: Bool) -> some View {
        ZStack {
            Circle()
                .fill(thumbColor.gradient)
                .fill(LinearGradient(colors: [
                    Color.white.opacity(0.6),
                    Color.gray.opacity(0.4),
                    Color.white.opacity(0.8)
                ],
                                     startPoint: .top,
                                     endPoint: .bottom))
                .stroke(LinearGradient(colors: [
                    Color.black.opacity(0.4),
                    Color.gray.opacity(0.6)
                ],
                                       startPoint: .top,
                                       endPoint: .bottom), lineWidth: 1, antialiased: true)
            Circle()
                .fill(thumbColor.gradient)
                .rotationEffect(.degrees(180))
                .overlay {
                    toggleLight(isOn)
                }
                .scaleEffect(thumbScaleFactor)
        }
    }
    
    @ViewBuilder
    func toggleLight(_ isOn: Bool) -> some View {
        Circle()
            .fill(RadialGradient(gradient: Gradient(colors: thumbLightColor(isOn)),
                                 center: .center,
                                 startRadius: 0,
                                 endRadius: toggleWidth / 4))
            .opacity(isOn ? 1.0 : 0.0)
            .scaleEffect(isOn ? 0.4: 0.3)
            .animation(.easeOut.delay(0.15), value: isOn)
    }
    
    func thumbLightColor(_ isOn: Bool) -> [Color] {
        [
            .white,
            .white,
            Color(red: 0.67, green: 0.96, blue: 0.72).opacity(isOn ? 1.0 : 0.0),
            Color(red: 0.67, green: 0.96, blue: 0.72).opacity(isOn ? 0.4: 0.0),
            .clear.opacity(isOn ? 1.0 : 0.0)
        ]
    }
}

extension ToggleStyle where Self == MainframeToggleStyle {
    public static var mainframe: MainframeToggleStyle {
        MainframeToggleStyle()
    }
}

#Preview {
    @Previewable @State var value = true
    ZStack {
        Color(red: 0.91, green: 0.92, blue: 0.89)
            .ignoresSafeArea()
        Toggle(isOn: $value) {
            Text("Toggle")
        }
        .toggleStyle(.mainframe)
        .padding()
        .labelsHidden()
    }
}
