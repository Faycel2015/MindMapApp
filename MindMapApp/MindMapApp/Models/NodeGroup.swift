//
//  NodeGroup.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

struct NodeGroup: Identifiable, Codable {
    let id: UUID
    var name: String
    var nodeIds: Set<UUID>
}
