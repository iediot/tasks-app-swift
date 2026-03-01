//
//  TasksApp.swift
//  Tasks
//
//  Created by Tabirca Nicolae-Eduard on 01.03.2026.
//

import SwiftUI
import SwiftData

@main
struct TasksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}
