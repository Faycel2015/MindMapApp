//
//  ExportView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

import SwiftUI

struct ExportView: View {
    @ObservedObject var viewModel: MindMapViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ExportFormat.allCases, id: \.self) { format in
                    Button(action: {
                        exportMindMap(format: format)
                    }) {
                        Label(format.description, systemImage: format.icon)
                    }
                }
            }
            .navigationTitle("Export")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func exportMindMap(format: ExportFormat) {
        Task {
            do {
                let url = try await viewModel.exportToFormat(format)
                await MainActor.run {
                    // Show share sheet with URL
                    let activityVC = UIActivityViewController(
                        activityItems: [url],
                        applicationActivities: nil
                    )
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first,
                       let rootVC = window.rootViewController {
                        rootVC.present(activityVC, animated: true)
                    }
                }
            } catch {
                print("Export failed: \(error)")
            }
        }
    }
}

#Preview {
    ExportView()
}
