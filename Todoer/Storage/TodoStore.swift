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
            count = todos[index].todos?.count ?? 0
        }
        return count
    }

    /// create Todo List

    func createTodoList(title: String, image: Int) {
        todos.append(TodoList(title: title, image: image))
    }

    /// add Todo to list

    func addTodo(index: Int, content: String, image: Int, notificationState: Bool, reminderDate: Date) {
        todos[index].todos?.append(Todo(content: content, image: image, notificationState: notificationState, reminderDate: reminderDate))
    }

    /// edit Todo

    func replaceTodo(listIndex: Int, index: Int, content: String, image: Int, notificationState: Bool, reminderDate: Date) {
        todos[listIndex].todos![index] = Todo(content: content, image: image, notificationState: notificationState, reminderDate: reminderDate)
    }

    /// edit Todo List

    func editTodoList(title: String, image: Int, index: Int) {
        todos[index].title = title
        todos[index].image = image
    }

    /// testing

    func append() {
        createTodoList(title: "Random", image: 0)
        addTodo(index: 0, content: "Hello", image: 0, notificationState: false, reminderDate: Date())
    }

}

struct Todo: Identifiable {
    var id = UUID()
    var content: String
    var image: Int
    var notificationState: Bool
    var reminderDate: Date
}

struct TodoList: Identifiable {
    var id = UUID()
    var title: String
    var image: Int
    var todos: [Todo]?
}
