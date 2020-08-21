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
//        /// method to create and save a lists
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//
//        let listEntity = NSEntityDescription.entity(forEntityName: "TodoLists", in: context)
//        let todoEntity = NSEntityDescription.entity(forEntityName: "Todo", in: context)
//        let subTodoEntity = NSEntityDescription.entity(forEntityName: "SubTodo", in: context)
//
//        for list in todos {
//            /// for each list we create a new object
//            let newTodoList = NSManagedObject(entity: listEntity!, insertInto: context)
//            /// set local values here
//
//            //title
//            //imageSection
//            //imageRow
//            //createdAt
//            //todos
//
//            var todoObjects: [NSManagedObject] = []
//
//            for todos in list.todos {
//
//                let newTodoEntity = NSManagedObject(entity: todoEntity!, insertInto: context)
//                /// set local values for each todo here
//
//                //content
//                //imageSection
//                //imageRow
//                //notificationState
//                //reminderDate
//                //subTodos
//
//                todoObjects.append(newTodoEntity)
//
//                var subTodoObjects: [NSManagedObject] = []
//
//                for subs in todos.subTodos {
//                    let newSubTodoEntity = NSManagedObject(entity: subTodoEntity!, insertInto: context)
//                    /// set local values for each sub todo here
//
//                    //content
//
//                    subTodoObjects.append(newSubTodoEntity)
//                }
//            }
//        }
//        /// save
//        do {
//            try context.save()
//            } catch {
//            print("Failed saving")
//        }
    }

    /// restore todos
    func restoreTodos() {
    }

    /// App Screenshot - Automatically populates the app with lists and todos to test
    func populate() {
        /// names array for each of the lists
        let names = ["Daily Tasks", "Christmas Presents", "Gym Routine", "Building Work", "Weekly Tasks", "Resolutions", "Gym Personal Records", "Plan"]

        /// iconRow and Section for the list icon
        let iconsSection = [0, 3, 4, 4, 0, 4, 0, 0]
        let iconsRow = [3, 0, 2, 1, 3, 9, 6, 1]

        /// dateformatter, same used in AddList for authenticity
        let createdDay: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }()

        var index = 0
        while index <= 6 {
            createTodoList(title: names[index], imageSection: iconsSection[index], imageRow: iconsRow[index], createdAt: createdDay.string(from: Date()))

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
