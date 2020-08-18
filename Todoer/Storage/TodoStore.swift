//
//  TodoStore.swift
//  Todoer
//
//  Created by Andrew Lawler on 15/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI
import Combine

class TodoStore: ObservableObject {

    @Published var todos: [TodoList] = []

    /// count of [todos] and [todoslist]

    func todoListCount() -> Int {
        return todos.count
    }

    func todoCount(index: Int) -> Int {
        var count = 0
        if todoListCount() > 0 {
            count = todos[index].todos.count
        }
        return count
    }

    /// create Todo List

    func createTodoList(title: String, imageSection: Int, imageRow: Int, createdAt: String) {
        todos.append(TodoList(title: title, imageSection: imageSection, imageRow: imageRow, createdAt: createdAt))
    }

    /// add Todo to list

    func addTodo(index: Int, content: String, imageSection: Int, imageRow: Int, notificationState: Bool, reminderDate: Date) {
        todos[index].todos.append(Todo(content: content, imageSection: imageSection, imageRow: imageRow, notificationState: notificationState, reminderDate: reminderDate))
    }

    /// edit Todo

    func replaceTodo(listIndex: Int, index: Int, content: String, imageSection: Int, imageRow: Int, notificationState: Bool, reminderDate: Date) {
        todos[listIndex].todos[index] = Todo(content: content, imageSection: imageSection, imageRow: imageRow, notificationState: notificationState, reminderDate: reminderDate)
    }

    /// edit Todo List

    func editTodoList(title: String, imageSection: Int, imageRow: Int, index: Int) {
        todos[index].title = title
        todos[index].imageRow = imageRow
        todos[index].imageSection = imageSection
    }

}

struct Todo: Identifiable {
    var id = UUID()
    var content: String
    var imageSection: Int
    var imageRow: Int
    var notificationState: Bool
    var reminderDate: Date
}

struct TodoList: Identifiable {
    var id = UUID()
    var title: String
    var imageSection: Int
    var imageRow: Int
    var todos = [Todo]()
    var createdAt: String
}
