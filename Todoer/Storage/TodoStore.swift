//
//  TodoStore.swift
//  Todoer
//
//  Created by Andrew Lawler on 15/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

class TodoStore: ObservableObject {

    /// storage of our todos

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
    }

    /// restore todos

    func restoreTodos() {
    }

    /// App Screenshot

    func populate() {
        /// call this function when i need a screenshot
        var index = 0
        let names = ["Daily Tasks", "Christmas Presents", "Gym Routine", "Building Work", "Weekly Tasks", "Resolutions", "Gym Personal Records", "Plan"]
        let iconsSection = [0, 3, 4, 4, 0, 4, 0, 0]
        let iconsRow = [3, 0, 2, 1, 3, 9, 6, 1]
        while index <= 6 {
            createTodoList(title: names[index], imageSection: iconsSection[index], imageRow: iconsRow[index], createdAt: "Aug 18, 2020")

            addTodo(index: index, content: "Send E-mail to Ben", imageSection: 3, imageRow: 0, notificationState: false, reminderDate: Date())
            addSubTodo(title: "Don't forget to attach the file", index: index, todoIndex: 0)

            addTodo(index: index, content: "Get work done", imageSection: 0, imageRow: 3, notificationState: false, reminderDate: Date())

            addTodo(index: index, content: "Eat the pasta for lunch", imageSection: 4, imageRow: 9, notificationState: false, reminderDate: Date())
            addSubTodo(title: "Wash up the tupperware", index: index, todoIndex: 2)

            addTodo(index: index, content: "Get Shopping", imageSection: 0, imageRow: 2, notificationState: false, reminderDate: Date())

            addTodo(index: index, content: "Take kids to football practice", imageSection: 0, imageRow: 6, notificationState: false, reminderDate: Date())
            addSubTodo(title: "Pick kids up", index: index, todoIndex: 4)

            addTodo(index: index, content: "Ring Mum", imageSection: 0, imageRow: 4, notificationState: false, reminderDate: Date())

            addTodo(index: index, content: "Take the trash out", imageSection: 4, imageRow: 8, notificationState: false, reminderDate: Date())
            addSubTodo(title: "Remember to add a new bin bag", index: index, todoIndex: 6)

            addTodo(index: index, content: "Promote my app", imageSection: 4, imageRow: 9, notificationState: false, reminderDate: Date())
            index += 1
        }
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
