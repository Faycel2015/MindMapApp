//
//  AnimationExtensions.swift
//  MindMapApp
//
//  Created by FayTek on 1/14/25.
//

import Foundation
import SwiftUI

extension Animation {
    static func smoothSpring() -> Animation {
        Animation.spring(response: 0.5, dampingFraction: 0.7)
    }
}
