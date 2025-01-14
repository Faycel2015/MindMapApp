//
//  ForceDirectedLayout.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

extension MindMapViewModel {
    private struct ForceVector {
        var dx: CGFloat = 0
        var dy: CGFloat = 0
    }
    
    /// Updates the layout of nodes using a force-directed graph algorithm.
    func updateLayout() {
        let iterations = 100 // Number of iterations for the algorithm
        let k: CGFloat = 100 // Optimal distance between nodes
        let springConstant: CGFloat = 0.1 // Strength of the spring force
        let repulsionConstant: CGFloat = 1000 // Strength of the repulsion force
        
        for _ in 0..<iterations {
            var forces = [UUID: ForceVector]()
            
            // Initialize force vectors for all nodes
            for node in nodes.values {
                forces[node.id] = ForceVector()
            }
            
            // Calculate repulsion forces between all pairs of nodes
            for node1 in nodes.values {
                for node2 in nodes.values where node1.id != node2.id {
                    let dx = node2.position.x - node1.position.x
                    let dy = node2.position.y - node1.position.y
                    let distance = sqrt(dx * dx + dy * dy)
                    
                    if distance > 0 {
                        // Calculate the repulsion force
                        let force = repulsionConstant / (distance * distance)
                        let fx = (dx / distance) * force
                        let fy = (dy / distance) * force
                        
                        // Apply the force to both nodes
                        forces[node1.id]?.dx -= fx
                        forces[node1.id]?.dy -= fy
                        forces[node2.id]?.dx += fx
                        forces[node2.id]?.dy += fy
                    }
                }
            }
            
            // Calculate spring forces for connected nodes
            for node in nodes.values {
                for childId in node.childIds {
                    guard let child = nodes[childId] else { continue }
                    
                    let dx = child.position.x - node.position.x
                    let dy = child.position.y - node.position.y
                    let distance = sqrt(dx * dx + dy * dy)
                    
                    if distance > 0 {
                        // Calculate the spring force
                        let force = springConstant * (distance - k)
                        let fx = (dx / distance) * force
                        let fy = (dy / distance) * force
                        
                        // Apply the force to both nodes
                        forces[node.id]?.dx += fx
                        forces[node.id]?.dy += fy
                        forces[child.id]?.dx -= fx
                        forces[child.id]?.dy -= fy
                    }
                }
            }
            
            // Apply forces to update node positions
            for (id, force) in forces {
                var node = nodes[id]!
                node.position = CGPoint(
                    x: node.position.x + force.dx,
                    y: node.position.y + force.dy
                )
                nodes[id] = node
            }
        }
        
        // Notify the view that the layout has been updated
        objectWillChange.send()
    }
}
