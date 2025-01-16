//
//  CollaborationUser.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

// Extend Color to Conform to Codable
extension Color: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let components = try container.decode([Double].self)
        guard components.count == 4 else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid number of color components"
            )
        }
        self = Color(
            red: components[0],
            green: components[1],
            blue: components[2],
            opacity: components[3]
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        guard let components = self.cgColor?.components, components.count >= 4 else {
            throw EncodingError.invalidValue(
                self,
                EncodingError.Context(
                    codingPath: encoder.codingPath,
                    debugDescription: "Invalid CGColor components"
                )
            )
        }
        try container.encode([components[0], components[1], components[2], components[3]])
    }
}

// CollaborationUser
struct CollaborationUser: Identifiable, Codable {
    let id: UUID
    var name: String
    var color: Color
    var lastActive: Date

    mutating func updateLastActive() {
        lastActive = Date()
    }
}
