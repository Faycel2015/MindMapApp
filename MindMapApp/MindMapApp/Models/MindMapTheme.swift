//
//  MindMapTheme.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

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
