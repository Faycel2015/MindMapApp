//
//  NodeView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct NodeView: View {
    let node: MindMapNode
    @ObservedObject var viewModel: MindMapViewModel
    @State private var isEditing = false
    
    var body: some View {
        nodeShape
            .overlay(nodeContent)
            .gesture(nodeDragGesture)
            .accessibilityLabel(node.accessibilityLabel)
            .accessibilityHint(node.accessibilityHint)
            .sheet(isPresented: $isEditing) {
                NodeEditView(node: node, viewModel: viewModel)
            }
    }
    
    private var nodeShape: some View {
        Group {
            switch node.shape {
            case .roundedRect:
                RoundedRectangle(cornerRadius: 8)
            case .circle:
                Circle()
            case .diamond:
                Diamond()
            }
        }
        .fill(node.color.color.opacity(0.2))
        .frame(width: 120, height: 80)
        .overlay(
            Group {
                switch node.shape {
                case .roundedRect:
                    RoundedRectangle(cornerRadius: 8)
                case .circle:
                    Circle()
                case .diamond:
                    Diamond()
                }
            }
            .stroke(node.color.color, lineWidth: 2)
        )
    }
    
    private var nodeContent: some View {
        Text(node.title)
            .lineLimit(3)
            .multilineTextAlignment(.center)
            .padding(8)
    }
    
    private var nodeDragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                // Update node position
                var updatedNode = node
                updatedNode.position = CGPoint(
                    x: node.position.x + value.translation.width,
                    y: node.position.y + value.translation.height
                )
                viewModel.nodes[node.id] = updatedNode
            }
    }
}

#Preview {
    NodeView(node: MindMapNode, viewModel: MindMapViewModel)
}
