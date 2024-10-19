//
//  MainframeToggleStyle.swift
//  mainframeUI
//
//  Created by Tomas Martins on 19/10/24.
//

import SwiftUI

public struct MainframeToggleStyle: ToggleStyle {
    var thumbColor: Color {
        Color(red: 0.82, green: 0.85, blue: 0.79)
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        LabeledContent {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 32)
                    .stroke(thumbColor
                        .shadow(.inner(color: .black.opacity(0.4), radius: 3, y: -2))
                        .shadow(.inner(color: .white.opacity(0.6), radius: 3, y: 2)),
                            lineWidth: 6)
                    .fill(configuration.isOn ? Color.green.gradient : Color.gray.gradient)
                    .rotationEffect(.degrees(180))
                    .frame(width: 56, height: 36)
                    .overlay {
                        thumb(configuration.isOn)
                            .foregroundStyle(thumbColor.gradient)
                            .frame(width: 36, height: 36)
                            .offset(x: configuration.isOn ? 10 : -10)
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
                    .animation(.bouncy, value: configuration.isOn)
                    .onTapGesture {
                        withAnimation {
                            configuration.isOn.toggle()
                        }
                    }
            }
            .frame(width: 56, height: 36)
        } label: {
            configuration.label
        }
    }
    
    func thumb(_ isOn: Bool) -> some View {
        ZStack {
            Circle()
                .fill(LinearGradient(colors: [
                    Color.white,
                    Color.gray,
                    Color.white
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
                .overlay {
                    toggleLight(isOn)
                }
                .scaleEffect(0.85)
        }
    }
    
    @ViewBuilder
    func toggleLight(_ isOn: Bool) -> some View {
        Circle()
            .fill(RadialGradient(gradient: Gradient(colors: thumbLightColor(isOn)),
                                 center: .center,
                                 startRadius: 0,
                                 endRadius: 4))
            .frame(width: 8, height: 8)
            .animation(.smooth, value: isOn)
    }
    
    func thumbLightColor(_ isOn: Bool) -> [Color] {
        if isOn {
            [
                .white, .white, .green, .green.opacity(0.2)
            ]
        } else {
            [
                .gray, .green.opacity(0.0), .green.opacity(0.0)
            ]
        }
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
        VStack {
            Toggle(isOn: $value) {
                Text("Toggle")
            }
            .toggleStyle(.mainframe)
            
            Toggle(isOn: $value) {
                Text("Toggle")
            }
        }.padding()
    }.labelsHidden()
}
