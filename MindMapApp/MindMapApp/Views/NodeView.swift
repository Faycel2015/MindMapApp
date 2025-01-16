//
//  NodeView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct NodeView: View {
    let node: MindMapNode
    @EnvironmentObject var viewModel: MindMapViewModel
    @State private var isEditing = false
    @State private var isDragging = false
    @State private var showingAttachments = false
    
    private let nodeSize: CGSize = CGSize(width: 150, height: 100)
    
    var body: some View {
        ZStack {
            // Node shape with fill, stroke, and shadow
            node.shape.toShape()
                .fill(node.color.color.opacity(0.2)) // Fill color with opacity
                .frame(width: nodeSize.width, height: nodeSize.height)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2) // Add shadow
            
            node.shape.toShape()
                .stroke(node.color.color, lineWidth: isDragging ? 2.5 : 1.5) // Dynamic stroke width
                .frame(width: nodeSize.width, height: nodeSize.height)
            
            // Node content (text and attachments)
            nodeContent
        }
        .position(node.position) // Position the node
        .gesture(nodeDragGesture) // Add drag gesture
        .scaleEffect(isDragging ? 1.05 : 1.0) // Scale effect while dragging
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isDragging) // Smooth animation
        .contextMenu {
            Button(action: { isEditing = true }) {
                Label("Edit", systemImage: "pencil")
            }
            Button(action: { showingAttachments = true }) {
                Label("Attachments", systemImage: "paperclip")
            }
            Button(role: .destructive, action: {
                viewModel.deleteNode(id: node.id)
            }) {
                Label("Delete", systemImage: "trash")
            }
        }
        .sheet(isPresented: $isEditing) {
            NodeEditView(node: node, viewModel: viewModel)
        }
        .sheet(isPresented: $showingAttachments) {
            NodeAttachmentsView(nodeId: node.id)
        }
    }
    
    // Node content (text and attachments)
    private var nodeContent: some View {
        VStack(spacing: 8) {
            Text(node.title)
                .font(.system(size: 14, weight: .medium))
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding(.horizontal, 8)
            
            if let attachments = viewModel.attachments[node.id], !attachments.isEmpty {
                HStack(spacing: 4) {
                    Image(systemName: "paperclip")
                        .font(.caption2)
                    Text("\(attachments.count)")
                        .font(.caption2)
                }
                .foregroundColor(.secondary)
            }
        }
        .padding(12)
        .frame(width: nodeSize.width, height: nodeSize.height)
    }
    
    // Drag gesture for moving nodes
    private var nodeDragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                isDragging = true
                var updatedNode = node
                updatedNode.position = CGPoint(
                    x: node.position.x + gesture.translation.width / viewModel.scale,
                    y: node.position.y + gesture.translation.height / viewModel.scale
                )
                viewModel.nodes[node.id] = updatedNode
            }
            .onEnded { _ in
                isDragging = false
                viewModel.updateLayout()
            }
    }
}

#Preview {
    NodeView(node: MindMapNode(
        id: UUID(),
        title: "Example Node",
        position: .zero,
        color: .blue,
        shape: .roundedRect
    ))
    .environmentObject(MindMapViewModel()) // Provide a viewModel for the preview
}
