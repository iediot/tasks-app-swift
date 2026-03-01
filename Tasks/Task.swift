//
//  Task.swift
//  Tasks
//
//  Created by Tabirca Nicolae-Eduard on 01.03.2026.
//

import Foundation
import SwiftData

@Model
class Task {
    var id: UUID = UUID()
    var title: String
    var isCompleted: Bool = false
    
    init(title: String, isCompleted: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
    }
}

