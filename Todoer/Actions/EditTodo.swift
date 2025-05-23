//
//  EditTodo.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI
import UserNotifications

struct EditTodo: View {

    @EnvironmentObject var todos: TodoStore
    
    var todoIndex: Int
    var iconRowIndex: Int
    var iconSectionIndex: Int

    @State var todoTitle = ""
    @State var notificationState = false
    @State var reminderDate = Date()
    @State var selectedIcon = 0

    @Binding var editTodo: Bool
    @Binding var index: Int

    @State var selectedIconRowIndex = 0
    @State var selectedIconSectionIndex = 0

    @State var masterNotificationPermissions = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Title")) {
                    TextField(todos.todos[index].todos[todoIndex].content, text: $todoTitle)
                        .foregroundColor(.primary)
                        .accentColor(Color(Constants.mainColor))
                }
                Section(header: Text("Icon")) {
                    NavigationLink(destination: IconChoice(selectedIconRowIndex: $selectedIconRowIndex, selectedIconSectionIndex: $selectedIconSectionIndex)) {
                        HStack {
                            Text("Please edit your icon")
                                .foregroundColor(Color.primary)
                            Spacer()
                            Image(systemName: Constants.iconsOrdered[self.selectedIconSectionIndex].icons[self.selectedIconRowIndex].systemName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                    }
                }
                if self.todos.todos[self.index].todos[self.todoIndex].notificationState == false || self.todos.todos[self.index].todos[todoIndex].reminderDate.timeIntervalSince(Date()) <= 0 {
                    Section(header: Text("Add Notifications?")) {
                        Toggle(isOn: $notificationState) {
                            HStack {
                                ZStack {
                                    Color(Constants.mainColor)
                                        .frame(width: 30, height: 30)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                    Image(systemName: "bell.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color.white)
                                }
                                Text("Notifications")
                                    .padding(.leading, 5)
                            }
                        }
                        if self.notificationState == true {
                            DatePicker(selection: $reminderDate, in: Date()..., displayedComponents: [.date, .hourAndMinute]) {
                                HStack {
                                    ZStack {
                                        Color(Constants.mainColor)
                                            .frame(width: 30, height: 30)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                        Image(systemName: "calendar")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color.white)
                                    }
                                    Text("Date/Time")
                                        .padding(.leading, 5)
                                }
                            }
                        }
                    }
                } else if self.todos.todos[self.index].todos[self.todoIndex].notificationState == true {
                    Section(header: Text("Edit Notifications?")) {
                        Toggle(isOn: $notificationState) {
                            HStack {
                                ZStack {
                                    Color(Constants.mainColor)
                                        .frame(width: 30, height: 30)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                    Image(systemName: "bell.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color.white)
                                }
                                Text("Notifications")
                                    .padding(.leading, 5)
                            }
                        }
                        if self.notificationState == true {
                            DatePicker(selection: $reminderDate, in: Date()..., displayedComponents: [.date, .hourAndMinute]) {
                                HStack {
                                    ZStack {
                                        Color(Constants.mainColor)
                                            .frame(width: 30, height: 30)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                        Image(systemName: "calendar")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(Color.white)
                                    }
                                    Text("Date/Time")
                                        .padding(.leading, 5)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Edit Task")
            .navigationBarItems(leading: Button(action: { self.editTodo.toggle() }) {
                Text("Cancel")
            }, trailing: Button(action: {
                if self.notificationState == true && self.reminderDate != self.todos.todos[self.index].todos[self.todoIndex].reminderDate && self.masterNotificationPermissions {
                    /// remove current Notification
                    if self.reminderDate.timeIntervalSince(Date()) > 0 {
                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.todos.todos[self.index].todos[self.todoIndex].id])
                        print("Removed Notification \(self.todos.todos[self.index].todos[self.todoIndex].id) ❌")
                    }
                    /// add new one
                    var seconds = self.reminderDate.timeIntervalSince(Date())
                    if seconds <= 0 { seconds = 5 }
                    print("⏱ \(seconds)")
                    let content = UNMutableNotificationContent()
                    content.title = self.todoTitle
                    content.subtitle = self.todos.todos[self.index].title
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
                    let request = UNNotificationRequest(identifier: self.todos.todos[self.index].todos[self.todoIndex].id, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request)
                    print("Added Notification \(self.todos.todos[self.index].todos[self.todoIndex].id) ✅")
                }
                if self.todoTitle == "" { self.todoTitle = self.todos.todos[self.index].todos[self.todoIndex].content }
                self.todos.replaceTodo(listIndex: self.index, index: self.todoIndex, content: self.todoTitle, imageSection: self.selectedIconSectionIndex, imageRow: self.selectedIconRowIndex, notificationState: self.masterNotificationPermissions ? self.notificationState : false, reminderDate: self.reminderDate)
                self.editTodo.toggle()
                self.todoTitle = ""
            }) {
                Text("Done").bold()
            })
        }.onAppear {
            self.todoTitle = self.todos.todos[self.index].todos[self.todoIndex].content
            self.selectedIconRowIndex = self.iconRowIndex
            self.selectedIconSectionIndex = self.iconSectionIndex
            self.notificationState = self.todos.todos[self.index].todos[self.todoIndex].notificationState
            if self.todos.todos[self.index].todos[self.todoIndex].reminderDate.timeIntervalSince(Date()) <= 0 {
                self.notificationState = false
            }
            if self.notificationState == false {
                self.reminderDate = Date()
            } else {
                self.reminderDate = self.todos.todos[self.index].todos[self.todoIndex].reminderDate
            }
            let id = UserDefaults.standard.integer(forKey: "notifications")
            if id == 1 { self.masterNotificationPermissions = true }
        }
    }
}

struct EditTodo_Previews: PreviewProvider {
    static var previews: some View {
        EditTodo(todoIndex: 0, iconRowIndex: 0, iconSectionIndex: 0, todoTitle: "", notificationState: false, reminderDate: Date(), selectedIcon: 0, editTodo: .constant(false), index: .constant(0))
    }
}
