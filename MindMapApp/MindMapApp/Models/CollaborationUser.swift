//
//  CollaborationUser.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

struct CollaborationUser: Identifiable, Codable {
    let id: UUID
    var name: String
    var color: Color
    var lastActive: Date
}
