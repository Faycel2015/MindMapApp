//
//  CollaborationUser.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

extension Color: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let components = try container.decode([CGFloat].self)
        self = Color(red: components[0], green: components[1], blue: components[2], opacity: components[3])
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let components = self.cgColor?.components {
            try container.encode([components[0], components[1], components[2], components[3]])
        }
    }
}

struct CollaborationUser: Identifiable, Codable {
    let id: UUID
    var name: String
    var color: Color
    var lastActive: Date
    
    mutating func updateLastActive() {
           lastActive = Date()
       }
}
