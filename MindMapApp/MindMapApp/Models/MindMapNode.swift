//
//  MindMapNode.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

struct MindMapNode: Identifiable, Codable {
    let id: UUID
    var title: String
    var position: CGPoint // CGPoint already conforms to Codable
    var color: NodeColor
    var shape: NodeShape
    var parentId: UUID?
    var childIds: Set<UUID>
    var attachments: [NodeAttachment] = []
    
    // Add accessibility properties
    var accessibilityLabel: String { title }
    var accessibilityHint: String { "Node in the mind map" }
    
    init(
        id: UUID = UUID(),
        title: String,
        position: CGPoint = .zero,
        color: NodeColor = .blue,
        shape: NodeShape = .roundedRect,
        parentId: UUID? = nil
    ) {
        self.id = id
        self.title = title
        self.position = position
        self.color = color
        self.shape = shape
        self.parentId = parentId
        self.childIds = []
    }
    
    mutating func addChild(_ childId: UUID) {
        childIds.insert(childId)
    }
    
    mutating func removeChild(_ childId: UUID) {
        childIds.remove(childId)
    }
}
