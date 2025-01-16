//
//  NodeAttachmentsView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct NodeAttachmentsView: View {
    let nodeId: UUID
    @EnvironmentObject private var viewModel: MindMapViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingAttachmentPicker = false
    @State private var selectedAttachmentType: NodeAttachment.AttachmentType?
    @State private var attachmentTitle = ""
    @State private var attachmentText = ""
    @State private var attachmentUrl = ""
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showingDocumentPicker = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add Attachment")) {
                    Menu("Add Attachment") {
                        Button("Add Link") {
                            selectedAttachmentType = .link
                        }
                        Button("Add Note") {
                            selectedAttachmentType = .note
                        }
                        Button("Add Image") {
                            selectedAttachmentType = .image
                            showingImagePicker = true
                        }
                        Button("Add File") {
                            selectedAttachmentType = .file
                            showingDocumentPicker = true
                        }
                    }
                }
                
                Section(header: Text("Attachments")) {
                    ForEach(viewModel.attachments[nodeId] ?? []) { attachment in
                        AttachmentRow(attachment: attachment) // Use AttachmentRow here
                    }
                    .onDelete { indexSet in
                        guard let attachments = viewModel.attachments[nodeId] else { return }
                        indexSet.forEach { index in
                            viewModel.removeAttachment(attachments[index].id, from: nodeId)
                        }
                    }
                }
            }
            .navigationTitle("Attachments")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $selectedImage)
            }
            .sheet(isPresented: $showingDocumentPicker) {
                DocumentPicker { url in
                    if let url = url {
                        addFileAttachment(url)
                    }
                }
            }
            .alert("Add Attachment", isPresented: Binding<Bool>(
                get: { selectedAttachmentType != nil },
                set: { if !$0 { selectedAttachmentType = nil } }
            )) {
                if let type = selectedAttachmentType {
                    switch type {
                    case .link:
                        TextField("Title", text: $attachmentTitle)
                        TextField("URL", text: $attachmentUrl)
                        Button("Add") {
                            addLinkAttachment()
                        }
                        Button("Cancel", role: .cancel) {}
                    case .note:
                        TextField("Title", text: $attachmentTitle)
                        TextField("Text", text: $attachmentText)
                        Button("Add") {
                            addNoteAttachment()
                        }
                        Button("Cancel", role: .cancel) {}
                    default:
                        EmptyView()
                    }
                }
            } message: {
                if let type = selectedAttachmentType {
                    switch type {
                    case .link:
                        Text("Enter the link URL and title")
                    case .note:
                        Text("Enter the note title and text")
                    default:
                        EmptyView()
                    }
                }
            }
        }
    }
    
    private func addLinkAttachment() {
        guard let url = URL(string: attachmentUrl) else { return }
        viewModel.addAttachment(
            to: nodeId,
            type: .link,
            title: attachmentTitle,
            data: .url(url)
        )
        resetAttachmentFields()
    }
    
    private func addNoteAttachment() {
        viewModel.addAttachment(
            to: nodeId,
            type: .note,
            title: attachmentTitle,
            data: .text(attachmentText)
        )
        resetAttachmentFields()
    }
    
    private func addImageAttachment(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        viewModel.addAttachment(
            to: nodeId,
            type: .image,
            title: attachmentTitle,
            data: .imageData(data)
        )
        resetAttachmentFields()
    }
    
    private func addFileAttachment(_ url: URL) {
        viewModel.addAttachment(
            to: nodeId,
            type: .file,
            title: url.lastPathComponent,
            data: .fileReference(url.path)
        )
        resetAttachmentFields()
    }
    
    private func resetAttachmentFields() {
        attachmentTitle = ""
        attachmentText = ""
        attachmentUrl = ""
        selectedImage = nil
    }
}

#Preview {
    NodeAttachmentsView(nodeId: UUID())
        .environmentObject(MindMapViewModel()) // Provide a viewModel for the preview
}
