//
//  SettingsView.swift
//  MindMapApp
//
//  Created by FayTek on 1/16/25.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: MindMapViewModel
    @AppStorage("username") private var username: String = ""
    @State private var showingThemeSettings = false
    @State private var showingCloudSync = false
    @State private var showingAbout = false
    @State private var notificationsEnabled = true
    @State private var autoSyncEnabled = true
    
    var body: some View {
        List {
            Section(header: Text("Profile")) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        TextField("Your Name", text: $username)
                            .font(.headline)
                        Text("Tap to edit")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }
            
            Section(header: Text("Appearance")) {
                Button(action: { showingThemeSettings = true }) {
                    SettingsRow(
                        icon: "paintpalette.fill",
                        iconColor: .orange,
                        title: "Themes",
                        subtitle: "Customize your mind map appearance"
                    )
                }
            }
            
            Section(header: Text("Sync & Backup")) {
                Button(action: { showingCloudSync = true }) {
                    SettingsRow(
                        icon: "icloud.fill",
                        iconColor: .blue,
                        title: "Cloud Sync",
                        subtitle: "Manage your cloud backups"
                    )
                }
                
                Toggle(isOn: $autoSyncEnabled) {
                    SettingsRow(
                        icon: "arrow.triangle.2.circlepath",
                        iconColor: .green,
                        title: "Auto Sync",
                        subtitle: "Automatically sync changes"
                    )
                }
            }
            
            Section(header: Text("Notifications")) {
                Toggle(isOn: $notificationsEnabled) {
                    SettingsRow(
                        icon: "bell.fill",
                        iconColor: .red,
                        title: "Notifications",
                        subtitle: "Get updates about your mind maps"
                    )
                }
            }
            
            Section(header: Text("About")) {
                Button(action: { showingAbout = true }) {
                    SettingsRow(
                        icon: "info.circle.fill",
                        iconColor: .blue,
                        title: "About",
                        subtitle: "Version 1.0.0"
                    )
                }
            }
        }
        .navigationTitle("Settings")
        .sheet(isPresented: $showingThemeSettings) {
            ThemeSettingsView()
        }
        .sheet(isPresented: $showingCloudSync) {
            CloudSyncView()
        }
        .sheet(isPresented: $showingAbout) {
            AboutView()
        }
    }
}

struct SettingsRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(iconColor)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct AboutView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(spacing: 16) {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.blue)
                        
                        Text("Mind Map App")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Version 1.0.0")
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
                }
                
                Section(header: Text("About")) {
                    Text("Mind Map App is a powerful tool for organizing your thoughts and ideas visually. Create beautiful mind maps, collaborate with others, and sync your data across devices.")
                        .font(.body)
                        .padding(.vertical, 8)
                }
                
                Section(header: Text("Support")) {
                    Link(destination: URL(string: "https://example.com/support")!) {
                        Label("Help Center", systemImage: "questionmark.circle")
                    }
                    
                    Link(destination: URL(string: "https://example.com/privacy")!) {
                        Label("Privacy Policy", systemImage: "hand.raised")
                    }
                    
                    Link(destination: URL(string: "https://example.com/terms")!) {
                        Label("Terms of Service", systemImage: "doc.text")
                    }
                }
            }
            .navigationTitle("About")
            .navigationBarItems(trailing: Button("Done") {
                // Dismiss the sheet
            })
        }
    }
}

#Preview {
    SettingsView()
}
