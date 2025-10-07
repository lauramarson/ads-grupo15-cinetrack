//
//  ShrinkButtonStyle.swift
//  cine-track
//
//  Created by Laura Marson on 09/09/25.
//

import SwiftUI

struct ShrinkButtonStyle: ButtonStyle {
    
    let shrinkScale: CGFloat
    let animationDuration: Double
    
    init(shrinkScale: CGFloat = 0.95, animationDuration: Double = 0.1) {
        self.shrinkScale = shrinkScale
        self.animationDuration = animationDuration
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? shrinkScale : 1.0)
            .animation(.easeInOut(duration: animationDuration), value: configuration.isPressed)
    }
}

// MARK: - Convenience Extension

extension ButtonStyle where Self == ShrinkButtonStyle {
    static var shrink: ShrinkButtonStyle {
        ShrinkButtonStyle()
    }
    
    static func shrink(scale: CGFloat = 0.95, duration: Double = 0.1) -> ShrinkButtonStyle {
        ShrinkButtonStyle(shrinkScale: scale, animationDuration: duration)
    }
}
