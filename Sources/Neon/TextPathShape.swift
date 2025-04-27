//
//  TextPathShape.swift
//  Neon
//
//  Created by Thang Kieu on 27/4/25.
//

import SwiftUI

struct TextPathShape: Shape {
    
    let text: String
    let font: NeonFont
    let strokeWidth: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let inset = strokeWidth / 2  // Leave room for stroke
        let availableRect = rect.insetBy(dx: inset, dy: inset)
        
        let attrString = NSAttributedString(string: text, attributes: [.font: font])
        let line = CTLineCreateWithAttributedString(attrString)
        let runs = CTLineGetGlyphRuns(line)
        
        var rawPath = Path()
        
        for runIndex in 0..<CFArrayGetCount(runs) {
            let run = unsafeBitCast(CFArrayGetValueAtIndex(runs, runIndex), to: CTRun.self)
            
            let attributes = CTRunGetAttributes(run) as NSDictionary
            let ctFont = attributes[kCTFontAttributeName as String] as! CTFont
            
            for glyphIndex in 0..<CTRunGetGlyphCount(run) {
                let range = CFRangeMake(glyphIndex, 1)
                var glyph = CGGlyph()
                var position = CGPoint()
                
                CTRunGetGlyphs(run, range, &glyph)
                CTRunGetPositions(run, range, &position)
                
                if let glyphPath = CTFontCreatePathForGlyph(ctFont, glyph, nil) {
                    let glyphSwiftPath = Path(glyphPath)
                    let transform = CGAffineTransform(translationX: position.x, y: position.y)
                    rawPath.addPath(glyphSwiftPath, transform: transform)
                }
            }
        }
        
        // Flip
        let rawBounds = rawPath.boundingRect
        var flippedPath = Path()
        flippedPath.addPath(rawPath, transform:
                                CGAffineTransform(translationX: 0, y: rawBounds.height)
            .scaledBy(x: 1, y: -1)
        )
        
        // Normalize
        let flippedBounds = flippedPath.boundingRect
        var normalizedPath = Path()
        normalizedPath.addPath(flippedPath, transform:
                                CGAffineTransform(translationX: -flippedBounds.minX, y: -flippedBounds.minY)
        )
        
        // Scale and center inside available rect (after insetting)
        let normalizedBounds = normalizedPath.boundingRect
        let scale = min(availableRect.width / normalizedBounds.width, availableRect.height / normalizedBounds.height)
        
        let xOffset = (availableRect.width - normalizedBounds.width * scale) / 2 + availableRect.minX
        let yOffset = (availableRect.height - normalizedBounds.height * scale) / 2 + availableRect.minY
        
        var finalPath = Path()
        finalPath.addPath(normalizedPath, transform:
                            CGAffineTransform(scaleX: scale, y: scale)
            .translatedBy(x: xOffset / scale, y: yOffset / scale)
        )
        
        return finalPath
    }
}
