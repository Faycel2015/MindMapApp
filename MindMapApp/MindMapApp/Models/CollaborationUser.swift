//
//  CollaborationUser.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI
import SwiftData

struct CollaborationUser: Identifiable, Codable {
    let id: UUID
    var name: String
    var color: Color
    var lastActive: Date
    
    mutating func updateLastActive() {
           lastActive = Date()
       }
}
