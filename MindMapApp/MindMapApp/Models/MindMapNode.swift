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
    var position: CGPoint
    var color: NodeColor
    var shape: NodeShape
    var parentId: UUID?
    var childIds: Set<UUID>
    var attachments: [NodeAttachment] = []
    
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
}
