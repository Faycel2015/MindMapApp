//
//  ExportFormat.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

enum ExportFormat: String, CaseIterable {
    case pdf, markdown, freemind, json
    
    var description: String {
        switch self {
        case .pdf: return "Export as PDF"
        case .markdown: return "Export as Markdown"
        case .freemind: return "Export as FreeMind"
        case .json: return "Export as JSON"
        }
    }
    
    var icon: String {
        switch self {
        case .pdf: return "doc.fill"
        case .markdown: return "text.alignleft"
        case .freemind: return "map"
        case .json: return "curlybraces"
        }
    }
    
    var fileExtension: String {
        rawValue
    }
}
