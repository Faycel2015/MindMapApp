//
//  ContentView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: MindMapViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Dashboard Tab
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Label("Dashboard", systemImage: "square.grid.2x2")
            }
            .tag(0)
            
            // Mind Maps Tab
            NavigationStack {
                MindMapView()
            }
            .tabItem {
                Label("Mind Maps", systemImage: "map")
            }
            .tag(1)
            
            // Collaboration Tab
            NavigationStack {
                CollaborationView()
            }
            .tabItem {
                Label("Collaborate", systemImage: "person.2")
            }
            .tag(2)
            
            // Settings Tab
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
            .tag(3)
        }
        .environmentObject(viewModel) // Pass the viewModel down the hierarchy
    }
}

#Preview {
    ContentView()
        .environmentObject(MindMapViewModel()) // Provide a viewModel for the preview
}
