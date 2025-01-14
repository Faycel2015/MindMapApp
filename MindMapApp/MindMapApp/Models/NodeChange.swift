//
//  NodeChange.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

struct NodeChange: Codable {
    let nodeId: UUID
    let userId: UUID
    let timestamp: Date
    let type: ChangeType
    
    enum ChangeType: String, Codable {
        case create, update, delete, move, addAttachment, removeAttachment
    }
}
