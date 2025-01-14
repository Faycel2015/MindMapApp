//
//  MindMapTheme.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

struct MindMapTheme: Codable, Identifiable {
    let id: UUID
    var name: String
    var backgroundColor: Color
    var nodeColors: [NodeColor]
    var fontName: String
    var connectionStyle: ConnectionStyle
    
    enum ConnectionStyle: String, Codable {
        case straight, curved, orthogonal, bezier
    }
    
    static let defaultTheme = MindMapTheme(
        id: UUID(),
        name: "Default",
        backgroundColor: .white,
        nodeColors: [.blue, .green, .red, .purple, .orange],
        fontName: "SF Pro",
        connectionStyle: .curved
    )
}
