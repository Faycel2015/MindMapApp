//
//  ThemeSettingsView.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import SwiftUI

struct ThemeSettingsView: View {
    @ObservedObject var viewModel: MindMapViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var editingTheme: MindMapTheme?
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Current Theme")) {
                    ThemePreview(theme: viewModel.currentTheme)
                }
                
                Section(header: Text("Available Themes")) {
                    ForEach(viewModel.availableThemes) { theme in
                        ThemeRow(theme: theme)
                            .onTapGesture {
                                viewModel.currentTheme = theme
                            }
                    }
                }
            }
            .navigationTitle("Themes")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct ThemePreview: View {
    let theme: MindMapTheme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(theme.name)
                .font(.headline)
            
            HStack {
                ForEach(theme.nodeColors, id: \.self) { color in
                    Circle()
                        .fill(color.color) // Ensure color.color is a Color
                        .frame(width: 20, height: 20)
                }
            }
            
            Text("Connection Style: \(theme.connectionStyle.rawValue.capitalized)")
                .font(.caption)
        }
        .padding()
        .background(theme.backgroundColor)
        .cornerRadius(8)
    }
}

#Preview {
    ThemeSettingsView(viewModel: MindMapViewModel())
}
