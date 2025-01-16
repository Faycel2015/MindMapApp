//
//  MindMapView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct MindMapView: View {
    @EnvironmentObject private var viewModel: MindMapViewModel
    @GestureState private var dragOffset: CGSize = .zero
    @GestureState private var scale: CGFloat = 1.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background with pan and zoom gestures
                Color.clear
                    .contentShape(Rectangle())
                    .gesture(
                        SimultaneousGesture(
                            MagnificationGesture()
                                .updating($scale) { value, state, _ in
                                    state = value
                                }
                                .onEnded { value in
                                    viewModel.scale *= value
                                },
                            DragGesture()
                                .updating($dragOffset) { value, state, _ in
                                    state = value.translation
                                }
                                .onEnded { value in
                                    viewModel.offset = CGSize(
                                        width: viewModel.offset.width + value.translation.width,
                                        height: viewModel.offset.height + value.translation.height
                                    )
                                }
                        )
                    )
                
                // Draw connections between nodes
                ForEach(Array(viewModel.nodes.values)) { node in
                    NodeConnectionsView(node: node) // Remove the viewModel parameter
                }
                
                // Draw nodes
                ForEach(Array(viewModel.nodes.values)) { node in
                    NodeView(node: node) // Remove the viewModel parameter
                        .position(
                            x: node.position.x * viewModel.scale + viewModel.offset.width + dragOffset.width,
                            y: node.position.y * viewModel.scale + viewModel.offset.height + dragOffset.height
                        )
                        .scaleEffect(viewModel.scale * scale)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.white) // Add a background color for debugging
        }
        .onAppear {
            // Debugging: Print node information when the view appears
            print("Nodes: \(viewModel.nodes)")
            print("Node positions: \(viewModel.nodes.map { $0.value.position })")
        }
    }
}

#Preview {
    MindMapView()
        .environmentObject(MindMapViewModel()) // Provide a viewModel for the preview
}
