//
//  MindMapViewModel.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

class MindMapViewModel: ObservableObject {
    @Published var nodes: [UUID: MindMapNode] = [:]
    
    func addNode(title: String, parentId: UUID?) {
        let newNode = MindMapNode(title: title, parentId: parentId)
        nodes[newNode.id] = newNode
        
        if let parentId = parentId {
            nodes[parentId]?.childIds.insert(newNode.id)
        }
        
        // Update the layout after adding a new node
        updateLayout()
    }
    
    func deleteNode(id: UUID) {
        guard let node = nodes[id] else { return }
        
        // Remove from parent's children
        if let parentId = node.parentId {
            nodes[parentId]?.childIds.remove(id)
        }
        
        // Recursively delete children
        for childId in node.childIds {
            deleteNode(id: childId)
        }
        
        nodes.removeValue(forKey: id)
        
        // Update the layout after deleting a node
        updateLayout()
    }
    
    // Remove the empty updateLayout() function
}
