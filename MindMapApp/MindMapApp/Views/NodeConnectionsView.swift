//
//  NodeConnectionsView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct NodeConnectionsView: View {
    let node: MindMapNode
    @EnvironmentObject private var viewModel: MindMapViewModel // Use @EnvironmentObject
    
    var body: some View {
        ForEach(Array(node.childIds), id: \.self) { childId in
            if let childNode = viewModel.nodes[childId] {
                Path { path in
                    path.move(to: node.position)
                    path.addLine(to: childNode.position)
                }
                .stroke(node.color.color, lineWidth: 1)
            }
        }
    }
}

#Preview {
    let viewModel = MindMapViewModel()
    var parentNode = MindMapNode(
        id: UUID(),
        title: "Parent Node",
        position: CGPoint(x: 100, y: 100),
        color: .blue,
        shape: .roundedRect
    )
    let childNode = MindMapNode(
        id: UUID(),
        title: "Child Node",
        position: CGPoint(x: 200, y: 200),
        color: .green,
        shape: .circle
    )
    parentNode.childIds.insert(childNode.id)
    viewModel.nodes[parentNode.id] = parentNode
    viewModel.nodes[childNode.id] = childNode
    
    return NodeConnectionsView(node: parentNode)
        .environmentObject(viewModel) // Pass viewModel via environment
}
