//
//  DocumentPicker.swift
//  MindMapApp
//
//  Created by FayTek on 1/15/25.
//

import Foundation
import SwiftUI

struct DocumentPicker: UIViewControllerRepresentable {
    var onPick: (URL?) -> Void // Accept an optional URL
    
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
                parent.onPick(url) // Pass the non-optional URL
            } else {
                parent.onPick(nil) // Pass nil if no URL is selected
            }
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.onPick(nil) // Pass nil if the picker is cancelled
        }
    }
}
