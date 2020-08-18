//
//  AddTodo.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct AddTodo: View {
    
    @EnvironmentObject var todos: TodoStore

    @State var todoTitle = ""
    @State var notificationState = false
    @State var reminderDate = Date()
    @State var selectedIcon = 0

    @Binding var index: Int
    @Binding var addTodo: Bool

    @State var selectedIconRowIndex = 0
    @State var selectedIconSectionIndex = 0

    @State var textfieldPlaceholder = "Todo title"

    @State var todoIndex = 0
    @State var subTodoToggle = false

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Add Title")) {
                    TextField(textfieldPlaceholder, text: $todoTitle)
                        .foregroundColor(.primary)
                        .accentColor(Constants.mainColor)
                }

                if self.todos.todos[self.index].todos.count != 0 {
                    Section(header: Text("Sub Todo?")) {
                        Toggle(isOn: $subTodoToggle) {
                            HStack {
                                ZStack {
                                    Constants.mainColor
                                        .frame(width: 30, height: 30)
                                        .clipShape(RoundedRectangle(cornerRadius: 5))
                                    Image(systemName: "text.badge.plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color.white)
                                }
                                Text("Add Sub Todo")
                                    .padding(.leading, 5)
                            }
                        }
                        if subTodoToggle {
                            Picker(selection: $todoIndex, label: Text("Add to main todo")){
                                ForEach(0 ..< self.todos.todos[self.index].todos.count) {
                                    Text(self.todos.todos[self.index].todos[$0].content)
                                }
                            }
                        }
                    }
                }
                if !subTodoToggle {
                    Section(header: Text("Select Icon")) {
                        NavigationLink(destination: IconChoice(selectedIconRowIndex: $selectedIconRowIndex, selectedIconSectionIndex: $selectedIconSectionIndex)) {
                            HStack {
                                Text("Please select an icon")
                                    .foregroundColor(Color.primary)
                                Spacer()
                                Image(systemName: Constants.iconsOrdered[self.selectedIconSectionIndex].icons[self.selectedIconRowIndex].systemName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(Constants.mainColor)
                            }
                        }
                    }
                    Section(header: Text("Manage Notifications")) {
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
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Add Todo")
            .navigationBarItems(leading: 
                Button(action: { self.addTodo.toggle() }) {
                    Text("Cancel")
                }, trailing:
                Button(action: {
                    if self.todoTitle != "" {
                        if self.subTodoToggle {
                            self.todos.addSubTodo(title: self.todoTitle, index: self.index, todoIndex: self.todoIndex)
                        } else {
                            self.todos.addTodo(index: self.index, content: self.todoTitle, imageSection: self.selectedIconSectionIndex, imageRow: self.selectedIconRowIndex, notificationState: self.notificationState, reminderDate: self.reminderDate)
                        }
                        self.todoTitle = ""
                        self.addTodo.toggle()
                    } else {
                        self.textfieldPlaceholder = "Please add a todo title"
                    }
            }) {
                Text("Done").bold()
            })
        }
    }
}

struct AddTodo_Previews: PreviewProvider {
    static var previews: some View {
        AddTodo(todoTitle: "", notificationState: false, reminderDate: Date(), selectedIcon: 0, index: .constant(0), addTodo: .constant(false))
    }
}
