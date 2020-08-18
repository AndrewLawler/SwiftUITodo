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
        saveTodos()
    }

    /// delete Todo List

    func deleteTodoList(index: Int) {
        todos.remove(at: index)
        saveTodos()
    }

    /// edit Todo List

    func editTodoList(title: String, imageSection: Int, imageRow: Int, index: Int) {
        todos[index].title = title
        todos[index].imageRow = imageRow
        todos[index].imageSection = imageSection
        saveTodos()
    }

    /// add Todo to list

    func addTodo(index: Int, content: String, imageSection: Int, imageRow: Int, notificationState: Bool, reminderDate: Date) {
        todos[index].todos.append(Todo(content: content, imageSection: imageSection, imageRow: imageRow, notificationState: notificationState, reminderDate: reminderDate))
        saveTodos()
    }

    /// edit Todo

    func replaceTodo(listIndex: Int, index: Int, content: String, imageSection: Int, imageRow: Int, notificationState: Bool, reminderDate: Date) {
        todos[listIndex].todos[index] = Todo(content: content, imageSection: imageSection, imageRow: imageRow, notificationState: notificationState, reminderDate: reminderDate)
        saveTodos()
    }

    /// delete todo

    func deleteTodo(index: Int, todoIndex: Int) {
        todos[index].todos.remove(at: todoIndex)
        saveTodos()
    }

    /// add sub todo

    func addSubTodo(title: String, index: Int, todoIndex: Int) {
        todos[index].todos[todoIndex].subTodos.append(SubTodo(content: title))
        saveTodos()
    }

    /// edit sub todo

    func replaceSubTodo(listIndex: Int, index: Int, subTodoIndex: Int, content: String) {
        todos[listIndex].todos[index].subTodos[subTodoIndex] = SubTodo(content: content)
        saveTodos()
    }

    /// delete sub todo

    func deleteSubTodo(index: Int, todoIndex: Int, subTodoIndex: Int) {
        todos[index].todos[todoIndex].subTodos.remove(at: subTodoIndex)
        saveTodos()
    }

    /// save todos
    
    func saveTodos() {
        print("Saved Todos")
    }

    /// restore todos

    func restoreTodos() {
        print("Restored Todos")
    }

}

struct Todo: Identifiable {
    var id = UUID()
    var content: String
    var imageSection: Int
    var imageRow: Int
    var notificationState: Bool
    var reminderDate: Date
    var subTodos = [SubTodo]()
}

struct TodoList: Identifiable {
    var id = UUID()
    var title: String
    var imageSection: Int
    var imageRow: Int
    var todos = [Todo]()
    var createdAt: String
}

struct SubTodo: Identifiable {
    var id = UUID()
    var content: String
}
