//
//  AttachmentRow.swift
//  MindMapApp
//
//  Created by FayTek on 1/15/25.
//

import SwiftUI

struct AttachmentRow: View {
    let attachment: NodeAttachment
    
    var body: some View {
        HStack {
            switch attachment.type {
            case .link:
                Image(systemName: "link")
            case .note:
                Image(systemName: "note.text")
            case .image:
                Image(systemName: "photo")
            case .file:
                Image(systemName: "doc")
            }
            Text(attachment.title)
        }
    }
}

#Preview {
    AttachmentRow(attachment: NodeAttachment(
        id: UUID(),
        type: .link,
        title: "Example Link",
        data: .url(URL(string: "https://example.com")!)
    ))
}
