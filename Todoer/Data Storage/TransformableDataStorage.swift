//
//  TransformableDataStorage.swift
//  TaskList
//
//  Created by Andrew Lawler on 26/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import Foundation
import RealmSwift

/// structs to store inside Realm

class Todo: Object, Identifiable {
    @objc dynamic var id: String
    @objc dynamic var content: String
    @objc dynamic var imageSection: Int
    @objc dynamic var imageRow: Int
    @objc dynamic var notificationState: Bool
    @objc dynamic var reminderDate: Date
    var subTodos = List<SubTodo>()

    init(id: String, content: String, imageSection: Int, imageRow: Int, notificationState: Bool, reminderDate: Date) {
        self.id = id
        self.content = content
        self.imageSection = imageSection
        self.imageRow = imageRow
        self.notificationState = notificationState
        self.reminderDate = reminderDate
    }

    required init() {
        self.id = ""
        self.content = ""
        self.imageRow = 0
        self.imageSection = 0
        self.notificationState = false
        self.reminderDate = Date()
    }

}

class TodoList: Object, Identifiable {
    @objc dynamic var id: String
    @objc dynamic var title: String
    @objc dynamic var imageSection: Int
    @objc dynamic var imageRow: Int
    var todos = List<Todo>()
    @objc dynamic var createdAt: String

    init(id: String, title: String, imageSection: Int, imageRow: Int, createdAt: String) {
        self.id = id
        self.title = title
        self.imageSection = imageSection
        self.imageRow = imageRow
        self.createdAt = createdAt
    }

    required init() {
        self.id = ""
        self.title = ""
        self.imageSection = 0
        self.imageRow = 0
        self.createdAt = ""
    }
}

class SubTodo: Object, Identifiable {
    @objc dynamic var id: String
    @objc dynamic var content: String

    init(id: String, content: String) {
        self.id = id
        self.content = content
    }

    required init() {
        self.id = ""
        self.content = ""
    }
}
