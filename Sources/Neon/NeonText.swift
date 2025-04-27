//
//  NeonText.swift
//  Neon
//
//  Created by Thang Kieu on 27/4/25.
//

import SwiftUI

public struct NeonText: View {
    
    @Environment(\.neonTextConfiguration) private var config
    @Binding private var animated: Bool
    @State private var text: String
    
    public init(_ text: String, animated: Binding<Bool>) {
        self.text = text
        self._animated = animated
    }
    
    public var body: some View {
        TextPathShape(text: text,
                      font: config.font,
                      strokeWidth: config.lineWidth)
        .trim(from: animated ? config.trim.from : 0,
              to: animated ? config.trim.to: 1)
        .stroke(
            LinearGradient(
                gradient: Gradient(colors: config.colors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            style: StrokeStyle(lineWidth: config.lineWidth,
                               lineCap: .round,
                               lineJoin: .round,
                               dash: config.dash,
                               dashPhase: animated ? 0 : config.dashPhase)
        )
        .hueRotation(.degrees(animated ? 360 : 0))
        
        .animation(animated
                   ? .easeInOut(duration: config.duration)
            .repeatForever(autoreverses: config.autoreverses)
                   : .default,
                   value: animated)
        .scaledToFit()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .opacity(animated ? 1 : 0)
    }
}

@available(iOS 17.0, macOS 14.0, *)
#Preview {
    @Previewable @State var animated = false
    NeonText("Neon", animated: $animated)
        .neonText(dash: [3, 5])
        .neonText(lineWidth: 5)
        .neonText(duration: 5)
        .neonText(trim: .init(from: 1, to: 1))
        .padding(50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .onAppear() {
            animated = true
        }
}
