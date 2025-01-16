//
//  MindMapTheme.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

// MARK: - Theme
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
