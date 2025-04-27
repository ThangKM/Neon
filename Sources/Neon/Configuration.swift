//
//  Configuration.swift
//  Neon
//
//  Created by Thang Kieu on 27/4/25.
//

import SwiftUI


#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst)
import UIKit
public typealias NeonFont = UIFont
#elseif os(macOS)
import AppKit
public typealias NeonFont = NSFont
extension NSFont: @unchecked @retroactive Sendable { }
#endif

extension CGPoint {
    
    public init(from: CGFloat, to: CGFloat) {
        self.init(x: from, y: to)
    }
    
    public var from: CGFloat {
        x
    }
    
    public var to: CGFloat {
        y
    }
}

extension NeonText {
    public struct Configuration: Sendable {
        
        var lineWidth: CGFloat
        var duration: TimeInterval
        var dashPhase: CGFloat
        var dash: [CGFloat]
        var colors: [Color]
        var trim: CGPoint
        var font: NeonFont
        var autoreverses: Bool
        
        init(font: NeonFont = .boldSystemFont(ofSize: 50),
             trim: CGPoint = .init(from: 1, to: 1),
             lineWidth: CGFloat = 2,
             dash: [CGFloat] = [1,2],
             dashPhase: CGFloat = 30,
             duration: TimeInterval = 3,
             colors: [Color] = [.red, .orange, .yellow, .pink, .purple],
             autoreverses: Bool = true
        ) {
            self.lineWidth = lineWidth
            self.dash = dash
            self.dashPhase = dashPhase
            self.duration = duration
            self.colors = colors
            self.trim = trim
            self.font = font
            self.autoreverses = autoreverses
        }
    }
}

