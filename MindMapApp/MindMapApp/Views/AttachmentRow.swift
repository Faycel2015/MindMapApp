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
        HStack(spacing: 12) {
            // Icon for the attachment type
            Group {
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
            }
            .font(.system(size: 16, weight: .medium))
            .frame(width: 24, height: 24)
            .foregroundColor(.blue) // Use a consistent color for icons
            
            // Attachment title
            Text(attachment.title)
                .font(.system(size: 14, weight: .medium))
                .lineLimit(1) // Ensure the title doesn't overflow
                .foregroundColor(.primary)
            
            Spacer() // Push content to the left
        }
        .padding(.vertical, 8) // Add vertical padding
        .padding(.horizontal, 12) // Add horizontal padding
        .background(Color(.systemBackground)) // Use system background color
        .cornerRadius(8) // Rounded corners
        .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 1) // Subtle shadow
        .accessibilityElement(children: .combine) // Combine child elements for accessibility
        .accessibilityLabel(attachmentTitleForAccessibility) // Accessibility label
        .accessibilityHint("Attachment") // Accessibility hint
    }
    
    // Accessibility label based on attachment type
    private var attachmentTitleForAccessibility: String {
        switch attachment.type {
        case .link:
            return "Link: \(attachment.title)"
        case .note:
            return "Note: \(attachment.title)"
        case .image:
            return "Image: \(attachment.title)"
        case .file:
            return "File: \(attachment.title)"
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        // Preview for all attachment types
        AttachmentRow(attachment: NodeAttachment(
            id: UUID(),
            type: .link,
            title: "Example Link",
            data: .url(URL(string: "https://example.com")!)
        ))
        AttachmentRow(attachment: NodeAttachment(
            id: UUID(),
            type: .note,
            title: "Example Note",
            data: .text("This is a note.")
        ))
        AttachmentRow(attachment: NodeAttachment(
            id: UUID(),
            type: .image,
            title: "Example Image",
            data: .imageData(Data())
        ))
        AttachmentRow(attachment: NodeAttachment(
            id: UUID(),
            type: .file,
            title: "Example File",
            data: .fileReference("path/to/file")
        ))
    }
    .padding()
    .background(Color(.systemGroupedBackground)) // Use grouped background for preview
}
