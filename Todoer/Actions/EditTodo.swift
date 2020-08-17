//
//  EditTodo.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct EditTodo: View {

    @EnvironmentObject var todos: TodoStore
    
    var todoIndex: Int

    @State var todoTitle = ""
    @State var notificationState = false
    @State var reminderDate = Date()
    @State var selectedIcon = 0

    @Binding var editTodo: Bool
    @Binding var index: Int

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Edit Title")) {
                    TextField(todos.todos[index].todos[todoIndex].content, text: $todoTitle)
                        .foregroundColor(.black)
                        .accentColor(Constants.mainColor)
                        .background(Color.white)
                }
                Section(header: Text("Edit Icon")) {
                    Picker(selection: $selectedIcon, label: Text("Please choose an icon")) {
                        ForEach(0 ..< Constants.icons.count) {
                            Image(systemName: "\(Constants.icons[$0].name)")
                                .foregroundColor(Constants.mainColor)
                        }
                    }
                }
                Section(header: Text("Edit Notifications")) {
                    Toggle(isOn: $notificationState) {
                        HStack {
                            ZStack {
                                Constants.mainColor
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
                    DatePicker(selection: $reminderDate, in: ...Date(), displayedComponents: .date) {
                        HStack {
                            ZStack {
                                Constants.mainColor
                                    .frame(width: 30, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "calendar")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.white)
                            }
                            Text("Date")
                                .padding(.leading, 5)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Edit Todo")
            .navigationBarItems(leading: Button(action: { self.editTodo.toggle() }) {
                Text("Cancel")
            }, trailing: Button(action: {
                if !self.todoTitle.isEmpty {
                    self.todos.replaceTodo(listIndex: self.index, index: self.todoIndex, content: self.todoTitle, image: self.selectedIcon, notificationState: self.notificationState, reminderDate: self.reminderDate)
                }
                self.hideKeyboard()
                self.editTodo.toggle()
                self.todoTitle = ""
            }) {
                Text("Done").bold()
            })
        }
    }
}

struct EditTodo_Previews: PreviewProvider {
    static var previews: some View {
        EditTodo(todoIndex: 0, todoTitle: "", notificationState: false, reminderDate: Date(), selectedIcon: 0, editTodo: .constant(false), index: .constant(0))
    }
}
