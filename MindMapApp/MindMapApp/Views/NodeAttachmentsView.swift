//
//  NodeAttachmentsView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct NodeAttachmentsView: View {
    let nodeId: UUID
    @ObservedObject var viewModel: MindMapViewModel
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
                        AttachmentRow(attachment: attachment)
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
            .alert(item: $selectedAttachmentType) { type in
                switch type {
                case .link:
                    return Alert(
                        title: Text("Add Link"),
                        message: nil,
                        primaryButton: .default(Text("Add")) {
                            addLinkAttachment()
                        },
                        secondaryButton: .cancel()
                    )
                case .note:
                    return Alert(
                        title: Text("Add Note"),
                        message: nil,
                        primaryButton: .default(Text("Add")) {
                            addNoteAttachment()
                        },
                        secondaryButton: .cancel()
                    )
                default:
                    return Alert(title: Text(""))
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
    }
    
    private func addNoteAttachment() {
        viewModel.addAttachment(
            to: nodeId,
            type: .note,
            title: attachmentTitle,
            data: .text(attachmentText)
        )
    }
    
    private func addImageAttachment(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        viewModel.addAttachment(
            to: nodeId,
            type: .image,
            title: attachmentTitle,
            data: .imageData(data)
        )
    }
    
    private func addFileAttachment(_ url: URL) {
        viewModel.addAttachment(
            to: nodeId,
            type: .file,
            title: url.lastPathComponent,
            data: .fileReference(url.path)
        )
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true)
        }
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    var onPick: (URL) -> Void
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.item], asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let parent: DocumentPicker
        
        init(_ parent: DocumentPicker) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let url = urls.first {
                parent.onPick(url)
            }
        }
    }
}

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
    NodeAttachmentsView(nodeId: UUID(), viewModel: MindMapViewModel())
}
