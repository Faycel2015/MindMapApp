//
//  NodeShape.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

enum NodeShape: String, Codable, CaseIterable {
    case roundedRect, circle, diamond
    
    func toShape() -> AnyShape {
        switch self {
        case .roundedRect:
            return AnyShape(RoundedRectangle(cornerRadius: 8))
        case .circle:
            return AnyShape(Circle())
        case .diamond:
            return AnyShape(Diamond())
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}

// Type-erased wrapper for Shape
struct AnyShape: Shape {
    private let _path: @Sendable (CGRect) -> Path
    
    init<S: Shape>(_ shape: S) {
        _path = { rect in
            shape.path(in: rect)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        _path(rect)
    }
}
