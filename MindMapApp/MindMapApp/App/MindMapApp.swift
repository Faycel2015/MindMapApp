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
            MindMapView()
                .environmentObject(viewModel)
        }
    }
}
