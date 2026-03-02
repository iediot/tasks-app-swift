//
//  ContentView.swift
//  Tasks
//
//  Created by Tabirca Nicolae-Eduard on 01.03.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var taskCount: Int = 0
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var modelContext
    @State private var newTaskTitle: String = ""
    @FocusState private var isTextFieldFocused: Bool
    var body: some View {
        VStack {
            Text("Tasks App")
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
            
            HStack {
                TextField("New Task", text: $newTaskTitle)
                    .focused($isTextFieldFocused)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    .foregroundStyle(.primary)

                Button("Add") {
                    addTask()
                }
                .buttonStyle(.glassProminent)
                .disabled(newTaskTitle.isEmpty)
            }
            .padding(.bottom)
            .onTapGesture {
                isTextFieldFocused = false
            }
            
            // List of tasks
            List {
                ForEach(tasks) {task in
                    HStack {
                        Text(task.title)
                            .strikethrough(task.isCompleted)
                        Image(systemName: task.isCompleted ?
                              "checkmark.circle" : "circle")
                    }
                    .onTapGesture {
                        toggleTask(task)
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .scrollDismissesKeyboard(.interactively)
            .listStyle(.plain)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
            .shadow(radius: 10)
        }
        .padding()
    }
    
    private func addTask() {
        let newTask = Task(title: newTaskTitle)
        modelContext.insert(newTask) // save it to the database
        newTaskTitle = ""
        isTextFieldFocused = false
    }
    
    private func toggleTask(_ task: Task) {
        task.isCompleted.toggle()
    }
    
    // deletes task by swiping left
    private func deleteTask(at offsets: IndexSet){
        for index in offsets {
            modelContext.delete(tasks[index])
        }
    }
}

#Preview {
    ContentView()
}
