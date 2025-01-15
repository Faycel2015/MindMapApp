//
//  NodeAttachment.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

struct NodeAttachment: Identifiable, Codable {
    let id: UUID
    var type: AttachmentType
    var title: String
    var data: AttachmentData
    
    enum AttachmentType: String, Codable {
        case link, note, image, file
        
        // Conform to Identifiable
        var id: String { rawValue }
    }
    
    enum AttachmentData: Codable {
        case url(URL), text(String), imageData(Data), fileReference(String)
        
        enum CodingKeys: String, CodingKey {
            case url, text, imageData, fileReference
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let url = try container.decodeIfPresent(URL.self, forKey: .url) {
                self = .url(url)
            } else if let text = try container.decodeIfPresent(String.self, forKey: .text) {
                self = .text(text)
            } else if let imageData = try container.decodeIfPresent(Data.self, forKey: .imageData) {
                self = .imageData(imageData)
            } else if let fileReference = try container.decodeIfPresent(String.self, forKey: .fileReference) {
                self = .fileReference(fileReference)
            } else {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid attachment data")
                )
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .url(let url):
                try container.encode(url, forKey: .url)
            case .text(let text):
                try container.encode(text, forKey: .text)
            case .imageData(let data):
                try container.encode(data, forKey: .imageData)
            case .fileReference(let path):
                try container.encode(path, forKey: .fileReference)
            }
        }
    }
}
