//
//  NodeEditView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct NodeEditView: View {
    let node: MindMapNode
    @ObservedObject var viewModel: MindMapViewModel
    @Environment(\.dismiss) var dismiss
    @State private var title: String
    @State private var color: NodeColor
    @State private var shape: NodeShape
    
    init(node: MindMapNode, viewModel: MindMapViewModel) {
        self.node = node
        self.viewModel = viewModel
        _title = State(initialValue: node.title)
        _color = State(initialValue: node.color)
        _shape = State(initialValue: node.shape)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                
                Picker("Color", selection: $color) {
                    ForEach(NodeColor.allCases, id: \.self) { color in
                        Text(color.rawValue.capitalized)
                    }
                }
                
                Picker("Shape", selection: $shape) {
                    ForEach(NodeShape.allCases, id: \.self) { shape in
                        Text(shape.rawValue.capitalized)
                    }
                }
            }
            .navigationTitle("Edit Node")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        saveChanges()
                    }
                }
            }
        }
    }
    
    private func saveChanges() {
        var updatedNode = node
        updatedNode.title = title
        updatedNode.color = color
        updatedNode.shape = shape
        viewModel.nodes[node.id] = updatedNode
        dismiss()
    }
}

#Preview {
    let viewModel = MindMapViewModel()
    let node = MindMapNode(
        id: UUID(),
        title: "Example Node",
        position: CGPoint(x: 100, y: 100),
        color: .blue,
        shape: .roundedRect
    )
    viewModel.nodes[node.id] = node
    
    return NodeEditView(node: node, viewModel: viewModel)
}
