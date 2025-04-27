//
//  EnvironmentValues++.swift
//  Neon
//
//  Created by Thang Kieu on 27/4/25.
//

import SwiftUI

extension View {

    public func neonText(lineWidth: CGFloat) -> some View {
        environment(\.neonTextConfiguration.lineWidth, lineWidth)
    }
    
    public func neonText(trim: CGPoint) -> some View {
        environment(\.neonTextConfiguration.trim, trim)
    }
    
    public func neonText(duration: TimeInterval) -> some View {
        environment(\.neonTextConfiguration.duration, duration)
    }
    
    public func neonText(dash: [CGFloat]) -> some View {
        environment(\.neonTextConfiguration.dash, dash)
    }
    
    public func neonText(dashPhase: CGFloat) -> some View {
        environment(\.neonTextConfiguration.dashPhase, dashPhase)
    }
    
    public func neonText(colors: [Color]) -> some View {
        environment(\.neonTextConfiguration.colors, colors)
    }
    
    public func neonText(font: NeonFont) -> some View {
        environment(\.neonTextConfiguration.font, font)
    }
    
    public func neonText(autoreverses: Bool) -> some View {
        environment(\.neonTextConfiguration.autoreverses, autoreverses)
    }
}

extension EnvironmentValues {
    @Entry public var neonTextConfiguration = NeonText.Configuration()
}
