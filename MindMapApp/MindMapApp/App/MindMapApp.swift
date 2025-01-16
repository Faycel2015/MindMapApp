//
//  MindMapAppApp.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

@main
struct MindMapApp: App {
    @StateObject private var viewModel = MindMapViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView() // ContentView is now the root view
                .environmentObject(viewModel) // Pass the viewModel to the environment
        }
    }
}
