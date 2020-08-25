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

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Edit Title")) {
                    TextField(todos.todos[index].todos[todoIndex].content, text: $todoTitle)
                        .foregroundColor(.primary)
                        .accentColor(Constants.mainColor)
                }
                Section(header: Text("Edit Icon")) {
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
                                .foregroundColor(Constants.mainColor)
                        }
                    }
                }
//                Section(header: Text("Edit Notifications")) {
//                    Toggle(isOn: $notificationState) {
//                        HStack {
//                            ZStack {
//                                Constants.mainColor
//                                    .frame(width: 30, height: 30)
//                                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                                Image(systemName: "bell.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(Color.white)
//                            }
//                            Text("Notifications")
//                                .padding(.leading, 5)
//                        }
//                    }
//                    DatePicker(selection: $reminderDate, in: ...Date(), displayedComponents: .date) {
//                        HStack {
//                            ZStack {
//                                Constants.mainColor
//                                    .frame(width: 30, height: 30)
//                                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                                Image(systemName: "calendar")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(Color.white)
//                            }
//                            Text("Date")
//                                .padding(.leading, 5)
//                        }
//                    }
//                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Edit Task")
            .navigationBarItems(leading: Button(action: { self.editTodo.toggle() }) {
                Text("Cancel")
            }, trailing: Button(action: {
                if self.todoTitle == "" { self.todoTitle = self.todos.todos[self.index].todos[self.todoIndex].content }
                self.todos.replaceTodo(listIndex: self.index, index: self.todoIndex, content: self.todoTitle, imageSection: self.selectedIconSectionIndex, imageRow: self.selectedIconRowIndex, notificationState: self.notificationState, reminderDate: self.reminderDate)
                self.editTodo.toggle()
                self.todoTitle = ""
            }) {
                Text("Done").bold()
            })
        }.onAppear {
            self.todoTitle = self.todos.todos[self.index].todos[self.todoIndex].content
            self.selectedIconRowIndex = self.iconRowIndex
            self.selectedIconSectionIndex = self.iconSectionIndex
        }
    }
}

struct EditTodo_Previews: PreviewProvider {
    static var previews: some View {
        EditTodo(todoIndex: 0, iconRowIndex: 0, iconSectionIndex: 0, todoTitle: "", notificationState: false, reminderDate: Date(), selectedIcon: 0, editTodo: .constant(false), index: .constant(0))
    }
}
