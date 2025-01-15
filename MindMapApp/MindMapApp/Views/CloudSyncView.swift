//
//  CloudSyncView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI
import SwiftData


struct CloudSyncView: View {
    @ObservedObject var viewModel: MindMapViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Sync Status")) {
                    HStack {
                        statusIcon
                        VStack(alignment: .leading) {
                            Text(statusText)
                            if let date = viewModel.lastSyncDate {
                                Text("Last synced: \(date, style: .relative)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        Task {
                            await viewModel.syncToCloud()
                        }
                    }) {
                        Label("Sync to Cloud", systemImage: "arrow.up.doc")
                    }
                    
                    Button(action: {
                        Task {
                            await viewModel.syncFromCloud()
                        }
                    }) {
                        Label("Sync from Cloud", systemImage: "arrow.down.doc")
                    }
                }
                
                Section(header: Text("Export")) {
                    ForEach(ExportFormat.allCases, id: \.self) { format in
                        Button(action: {
                            exportMindMap(format: format)
                        }) {
                            Label(format.description, systemImage: format.icon)
                        }
                    }
                }
            }
            .navigationTitle("Cloud Sync")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private var statusIcon: some View {
        switch viewModel.syncStatus {
        case .idle:
            return Image(systemName: "cloud")
                .foregroundColor(.secondary)
        case .syncing:
            return Image(systemName: "arrow.2.circlepath")
                .foregroundColor(.blue)
        case .error:
            return Image(systemName: "exclamationmark.circle")
                .foregroundColor(.red)
        case .success:
            return Image(systemName: "checkmark.circle")
                .foregroundColor(.green)
        }
    }
    
    private var statusText: String {
        switch viewModel.syncStatus {
        case .idle:
            return "Ready to sync"
        case .syncing:
            return "Syncing..."
        case .error(let message):
            return "Error: \(message)"
        case .success:
            return "Sync complete"
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
    CloudSyncView(viewModel: MindMapViewModel())
}
