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
import RealmSwift

class TodoStore: ObservableObject {

    /// realm
    let realm = try! Realm()

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
        let list = TodoList(id: "\(UUID())", title: title, imageSection: imageSection, imageRow: imageRow, createdAt: createdAt)

        try! realm.write {
            realm.add(list)
        }

        reloadRealm()
    }

    /// delete Todo List
    func deleteTodoList(index: Int) {
        let list = realm.objects(TodoList.self).filter("id = '\(todos[index].id)'")

        try! realm.write {
            realm.delete(list)
        }

        reloadRealm()
    }

    /// edit Todo List
    func editTodoList(title: String, imageSection: Int, imageRow: Int, index: Int) {
        let lists = realm.objects(TodoList.self).filter("id = '\(todos[index].id)'")

        if let list = lists.first {
            try! realm.write {
                list.title = title
                list.imageRow = imageRow
                list.imageSection = imageSection
            }
        }

        reloadRealm()
    }

    /// edit notification state of list items
    func editTodoListTodosNotificationStates() {
        let lists = realm.objects(TodoList.self)
        try! realm.write {
            for list in lists {
                for todo in list.todos {
                    todo.notificationState = false
                }
            }
        }
        reloadRealm()
        print("Dequeued all notifications ✅")
    }

    /// add Todo to list
    func addTodo(index: Int, content: String, imageSection: Int, imageRow: Int, notificationState: Bool, reminderDate: Date) {

        let todo = Todo(id: "\(UUID())", content: content, imageSection: imageSection, imageRow: imageRow, notificationState: notificationState, reminderDate: reminderDate)

        let lists = realm.objects(TodoList.self).filter("id = '\(todos[index].id)'")

        if let list = lists.first {
            try! realm.write {
                list.todos.append(todo)
            }
        }

        reloadRealm()
    }

    /// edit Todo
    func replaceTodo(listIndex: Int, index: Int, content: String, imageSection: Int, imageRow: Int, notificationState: Bool, reminderDate: Date) {

        let todo = Todo(id: todos[listIndex].todos[index].id, content: content, imageSection: imageSection, imageRow: imageRow, notificationState: notificationState, reminderDate: reminderDate)
        todo.subTodos = todos[listIndex].todos[index].subTodos

        let lists = realm.objects(TodoList.self).filter("id = '\(todos[listIndex].id)'")

        if let list = lists.first {
            try! realm.write {
                list.todos[index] = todo
            }
        }

        reloadRealm()
    }

    /// delete todo
    func deleteTodo(index: Int, todoIndex: Int) {
        let lists = realm.objects(TodoList.self).filter("id = '\(todos[index].id)'")

        if let list = lists.first {
            try! realm.write {
                list.todos.remove(at: todoIndex)
            }
        }

        reloadRealm()
    }

    /// add sub todo
    func addSubTodo(title: String, index: Int, todoIndex: Int) {
        let subTodo = SubTodo(id: "\(UUID())", content: title)

        let lists = realm.objects(TodoList.self).filter("id = '\(todos[index].id)'")

        if let list = lists.first {
            try! realm.write {
                list.todos[todoIndex].subTodos.append(subTodo)
            }
        }

        reloadRealm()
    }

    /// edit sub todo
    func replaceSubTodo(listIndex: Int, index: Int, subTodoIndex: Int, content: String) {

        let subTodo = SubTodo(id: "\(UUID())", content: content)

        let lists = realm.objects(TodoList.self).filter("id = '\(todos[index].id)'")

        if let list = lists.first {
            try! realm.write {
                list.todos[index].subTodos[subTodoIndex] = subTodo
            }
        }

        reloadRealm()
    }

    /// delete sub todo
    func deleteSubTodo(index: Int, todoIndex: Int, subTodoIndex: Int) {
        let lists = realm.objects(TodoList.self).filter("id = '\(todos[index].id)'")

        if let list = lists.first {
            try! realm.write {
                list.todos[todoIndex].subTodos.remove(at: subTodoIndex)
            }
        }

        reloadRealm()
    }

    func reloadRealm() {
        todos = []
        let realm = try! Realm()
        let results = realm.objects(TodoList.self)
        for list in results {
            todos.append(list)
        }
    }

    /// move list
    func moveList(source: IndexSet, destination: Int) {
        try! realm.write {
            print(source)
            print(destination)
            todos.move(fromOffsets: source, toOffset: destination)
        }
        reloadRealm()
    }

    /// move todo
    func moveTodo(index: Int, source: IndexSet, destination: Int) {
        try! realm.write {
            todos[index].todos.move(fromOffsets: source, toOffset: destination)
        }
        reloadRealm()
    }
    
}
