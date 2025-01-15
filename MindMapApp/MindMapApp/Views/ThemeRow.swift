//
//  ThemeRow.swift
//  MindMapApp
//
//  Created by FayTek on 1/15/25.
//

import SwiftUI

struct ThemeRow: View {
    let theme: MindMapTheme
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(theme.name)
                    .font(.headline)
                
                HStack {
                    ForEach(theme.nodeColors, id: \.self) { color in
                        Circle()
                            .fill(color.color)
                            .frame(width: 20, height: 20)
                    }
                }
                
                Text("Connection Style: \(theme.connectionStyle.rawValue.capitalized)")
                    .font(.caption)
            }
            
            Spacer()
            
            if theme.id == MindMapTheme.defaultTheme.id {
                Image(systemName: "checkmark")
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .background(theme.backgroundColor.opacity(0.2))
        .cornerRadius(8)
    }
}

#Preview {
    ThemeRow(theme: MindMapTheme.defaultTheme)
}
