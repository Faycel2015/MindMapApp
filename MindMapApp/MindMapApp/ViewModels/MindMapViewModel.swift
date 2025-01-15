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
    @Published var attachments: [UUID: [NodeAttachment]] = [:]
    @Published var lastSyncDate: Date?
    @Published var syncStatus: SyncStatus = .idle
    @Published var collaborators: [UUID: CollaborationUser] = [:]
    @Published var changes: [NodeChange] = []
    
    enum SyncStatus {
        case idle, syncing, error(String), success
    }
    
    func exportToFormat(_ format: ExportFormat) async throws -> URL {
        // Implement export logic here
        return URL(fileURLWithPath: "example")
    }
    
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
    
    func addAttachment(to nodeId: UUID, type: NodeAttachment.AttachmentType, title: String, data: NodeAttachment.AttachmentData) {
        let newAttachment = NodeAttachment(id: UUID(), type: type, title: title, data: data)
        attachments[nodeId, default: []].append(newAttachment)
    }
    
    func removeAttachment(_ attachmentId: UUID, from nodeId: UUID) {
        attachments[nodeId]?.removeAll { $0.id == attachmentId }
    }
}
