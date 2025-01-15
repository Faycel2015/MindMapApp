//
//  MindMapTheme.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

// Extend Color to conform to Codable
extension Color: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let components = try container.decode([CGFloat].self)
        self = Color(red: components[0], green: components[1], blue: components[2], opacity: components[3])
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let components = self.cgColor?.components {
            try container.encode([components[0], components[1], components[2], components[3]])
        }
    }
}

struct MindMapTheme: Identifiable, Codable {
    let id: UUID
    var name: String
    var backgroundColor: Color
    var nodeColors: [NodeColor]
    var connectionStyle: ConnectionStyle
    
    enum ConnectionStyle: String, Codable {
        case straight, curved, orthogonal, bezier
    }
    
    static let defaultTheme = MindMapTheme(
        id: UUID(),
        name: "Default",
        backgroundColor: .white,
        nodeColors: [.blue, .green, .red, .purple, .orange],
        connectionStyle: .curved
    )
}

enum NodeColor: String, Codable, CaseIterable {
    case blue, green, red, purple, orange
    
    var color: Color {
        switch self {
        case .blue: return .blue
        case .green: return .green
        case .red: return .red
        case .purple: return .purple
        case .orange: return .orange
        }
    }
}
