//
//  CollaborationView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct CollaborationView: View {
    @ObservedObject var viewModel: MindMapViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var newUsername = ""
    @AppStorage("username") private var username: String = ""
    
    var body: some View {
        NavigationView {
            List {
                profileSection
                activeCollaboratorsSection
                recentChangesSection
            }
            .navigationTitle("Collaboration")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private var profileSection: some View {
        Section(header: Text("Your Profile")) {
            if username.isEmpty {
                TextField("Enter your name", text: $newUsername)
                Button("Join Collaboration") {
                    username = newUsername
                    let user = CollaborationUser(id: UUID(), name: newUsername, color: .blue, lastActive: Date())
                    viewModel.collaborators[user.id] = user
                }
                .disabled(newUsername.isEmpty)
            } else {
                Text("Joined as: \(username)")
                    .font(.headline)
            }
        }
    }
    
    private var activeCollaboratorsSection: some View {
        Section(header: Text("Active Collaborators")) {
            ForEach(Array(viewModel.collaborators.values)) { user in
                HStack {
                    Circle()
                        .fill(user.color)
                        .frame(width: 10, height: 10)
                    Text(user.name)
                    Spacer()
                    Text(user.lastActive, style: .relative)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private var recentChangesSection: some View {
        Section(header: Text("Recent Changes")) {
            ForEach(viewModel.changes.prefix(10), id: \.timestamp) { change in
                if let user = viewModel.collaborators[change.userId] {
                    HStack {
                        Circle()
                            .fill(user.color)
                            .frame(width: 10, height: 10)
                        VStack(alignment: .leading) {
                            Text("\(user.name) \(changeDescription(change))")
                            Text(change.timestamp, style: .relative)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
    }
    
    private func changeDescription(_ change: NodeChange) -> String {
        switch change.type {
        case .create:
            return "created a new node"
        case .update:
            return "updated a node"
        case .delete:
            return "deleted a node"
        case .move:
            return "moved a node"
        case .addAttachment:
            return "added an attachment"
        case .removeAttachment:
            return "removed an attachment"
        }
    }
}

#Preview {
    CollaborationView(viewModel: MindMapViewModel())
}
