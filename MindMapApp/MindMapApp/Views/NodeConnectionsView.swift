//
//  NodeConnectionsView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct NodeConnectionsView: View {
    let node: MindMapNode
    @ObservedObject var viewModel: MindMapViewModel
    
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
    NodeConnectionsView()
}
