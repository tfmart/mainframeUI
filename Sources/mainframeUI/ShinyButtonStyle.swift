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
                            y: configuration.isPressed ? 0 : -1
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
                    ), lineWidth: configuration.isPressed ? 2.5 : 1)
            }
            .compositingGroup()
            .shadow(color: .black.opacity(configuration.isPressed ? 0.0 : 0.5), radius:  1, y: 2)
            .overlay {
                if configuration.isPressed {
                    Capsule().fill(.black).opacity(0.1)
                }
            }
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.smooth(duration: 0.2), value: configuration.isPressed)
        
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
