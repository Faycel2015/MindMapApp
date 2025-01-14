//
//  NodeColor.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

enum NodeColor: String, Codable, CaseIterable {
    case blue, green, red, purple, orange
    
    var color: Color {
        switch self {
        case .blue: return Color.blue
        case .green: return Color.green
        case .red: return Color.red
        case .purple: return Color.purple
        case .orange: return Color.orange
        }
    }
}
