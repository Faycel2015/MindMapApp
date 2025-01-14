//
//  FileManagerExtensions.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation

extension FileManager {
    static func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
