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
    }
    
    enum AttachmentData: Codable {
        case url(URL), text(String), imageData(Data), fileReference(String)
    }
}
