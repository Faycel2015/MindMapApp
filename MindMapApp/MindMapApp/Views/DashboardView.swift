//
//  DashboardView.swift
//  MindMapApp
//
//  Created by FayTek on 1/16/25.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var viewModel: MindMapViewModel
    @State private var showingNewMap = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Stats Cards
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    StatCard(title: "Total Maps",
                           value: "\(viewModel.nodes.count)",
                           icon: "map")
                    
                    StatCard(title: "Collaborators",
                           value: "\(viewModel.collaborators.count)",
                           icon: "person.2")
                }
                .padding(.horizontal)
                
                // Recent Activity
                VStack(alignment: .leading, spacing: 12) {
                    Text("Recent Activity")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.changes.prefix(5), id: \.timestamp) { change in
                                ActivityCard(change: change)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                
                // Quick Actions
                VStack(alignment: .leading, spacing: 12) {
                    Text("Quick Actions")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    ActionButtonsGrid()
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("Dashboard")
        .sheet(isPresented: $showingNewMap) {
            MindMapView()
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.blue)
                Spacer()
            }
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct ActivityCard: View {
    let change: NodeChange
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: changeIcon)
                    .foregroundColor(.blue)
                Text(changeTitle)
                    .font(.headline)
            }
            
            Text(change.timestamp, style: .relative)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(width: 200)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    var changeIcon: String {
        switch change.type {
        case .create: return "plus.circle"
        case .update: return "pencil.circle"
        case .delete: return "minus.circle"
        case .move: return "arrow.up.right.circle"
        case .addAttachment: return "paperclip.circle"
        case .removeAttachment: return "paperclip.circle.fill"
        }
    }
    
    var changeTitle: String {
        switch change.type {
        case .create: return "New Node Created"
        case .update: return "Node Updated"
        case .delete: return "Node Deleted"
        case .move: return "Node Moved"
        case .addAttachment: return "Attachment Added"
        case .removeAttachment: return "Attachment Removed"
        }
    }
}

struct ActionButtonsGrid: View {
    @EnvironmentObject var viewModel: MindMapViewModel
    @State private var showingNewMap = false
    @State private var showingCloudSync = false
    @State private var showingThemes = false
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 16) {
            QuickActionButton(
                title: "New Mind Map",
                icon: "plus.circle.fill",
                color: .blue
            ) {
                showingNewMap = true
            }
            
            QuickActionButton(
                title: "Cloud Sync",
                icon: "icloud.fill",
                color: .purple
            ) {
                showingCloudSync = true
            }
            
            QuickActionButton(
                title: "Themes",
                icon: "paintpalette.fill",
                color: .orange
            ) {
                showingThemes = true
            }
            
            QuickActionButton(
                title: "Export",
                icon: "square.and.arrow.up.fill",
                color: .green
            ) {
                // Handle export action
            }
        }
        .sheet(isPresented: $showingNewMap) {
            MindMapView()
        }
        .sheet(isPresented: $showingCloudSync) {
            CloudSyncView()
        }
        .sheet(isPresented: $showingThemes) {
            ThemeSettingsView()
        }
    }
}

struct QuickActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        }
    }
}

#Preview {
    DashboardView()
}
