//
//  ListSelection.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

/// List selection is the screen in which you can change which list you are viewing
struct ListSelection: View {
    
    @EnvironmentObject var todos: TodoStore

    @State var addList = false
    @State var listTitle = ""
    @State var editList = false

    @Binding var index: Int
    @Binding var showLists: Bool

    @State var clickedEdit = false
    @State var editIndex = 0

    func recreateIndex(id: Int) -> Int {
        return (todos.todoListCount() - 1) - id
    }

    /// get the correct string needed for the todo
    func todoText(todos: Int) -> String {
        if todos == 1 { return Constants.listSelect.todo }
        else if todos == 0 || todos > 1 { return Constants.listSelect.todos }
        else { return Constants.listSelect.todo }
    }

    /// get the correct string needed for the sub todo
    func subTodoText(todos: Int) -> String {
        if todos == 1 { return Constants.listSelect.subtodo }
        else if todos == 0 || todos > 1 { return Constants.listSelect.subtodos }
        else { return Constants.listSelect.subtodo }
    }

    /// calculate how many sub todos each list has to then convert it to a sub todo text
    func calculateSubTodo(listIndex: Int) -> Int {
        var count = 0
        var index = 0
        while index < self.todos.todos[listIndex].todos.count {
            count += self.todos.todos[listIndex].todos[index].subTodos.count
            index += 1
        }
        return count
    }

    var body: some View {
        VStack {
            /// Custom NavigationView
            HStack {
                /// recreates the nav title style
                Text(Constants.listSelect.title).font(.largeTitle).bold()
                Spacer()
                /// HStack of the two buttons used in the view
                HStack {
                    Button(action: { self.addList.toggle() }) {
                        ZStack {
                            Color(Constants.color.darkMenuCircle)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
                            Image(systemName: Constants.images.addList)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                    }
                    //.padding(.trailing, 10)
                    .sheet(isPresented: $addList) {
                        AddList(addList: self.$addList, index: self.$index)
                            .environmentObject(self.todos)
                    }
                    //.padding(.trailing, 10)
//                    ZStack {
//                        Color(Constants.color.darkMenuCircle)
//                            .frame(width: 40, height: 40)
//                            .clipShape(Circle())
//                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
//                        EditButton()
//                            .font(.system(size: 13, weight: .bold))
//                            .foregroundColor(Constants.mainColor)
//                            .onTapGesture {
//                                self.clickedEdit.toggle()
//                            }
//                    }
                }
                /// adds a ring around the menu items in dark mode
                .frame(width: 135 - 60)
                .frame(height: 60)
                .background(Color(Constants.color.menuTab))
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }
            .padding(.top, 40)
            .padding(.horizontal, 20)

            /// list showing all the possible lists
            List {
                /// loop the todolists via their index
                ForEach(self.todos.todos.indices, id: \.self) { todoIndex in
                    HStack {
                        /// image with tap gesture to change the overall app index
                        ZStack {
                            Color(Constants.mainColor)
                                .frame(width: 80, height: 80)
                                .cornerRadius(20)
                            Image(systemName: Constants.iconsOrdered[self.todos.todos[self.recreateIndex(id: todoIndex)].imageSection].icons[self.todos.todos[self.recreateIndex(id: todoIndex)].imageRow].systemName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.white)
                        }.frame(width: 80, height: 80)
                        .onTapGesture {
                            self.index = self.recreateIndex(id: todoIndex)
                            self.showLists.toggle()
                        }
                        /// text with title, todos and creation date
                        VStack {
                            Text(self.todos.todos[self.recreateIndex(id: todoIndex)].title)
                                .font(.headline).bold()
                                .padding(.leading, 10)
                                .frame(width: 180, alignment: .leading)
                            Text("\(self.todos.todos[self.recreateIndex(id: todoIndex)].todos.count) \(self.todoText(todos: self.todos.todos[self.recreateIndex(id: todoIndex)].todos.count)), \(self.calculateSubTodo(listIndex: self.recreateIndex(id: todoIndex))) \(self.subTodoText(todos: self.calculateSubTodo(listIndex: self.recreateIndex(id: todoIndex))))")
                                .font(.system(size: 13, weight: .medium))
                                .padding(.leading, 10)
                                .frame(width: 180, height: 13, alignment: .leading)
                                .foregroundColor(.secondary)
                                .padding(.top, 10)
                            Text("Created: \(self.todos.todos[self.recreateIndex(id: todoIndex)].createdAt)")
                                .font(.system(size: 12, weight: .medium))
                                .padding(.leading, 10)
                                .frame(width: 180, height: 12, alignment: .leading)
                                .foregroundColor(Color.secondary.opacity(0.7))
                                .padding(.top, 5)
                        }

                        Spacer()

                        /// more button to edit the list
                        Button(action: {
                            self.editIndex = self.recreateIndex(id: todoIndex)
                            self.editList.toggle()
                        }) {
                            Image(systemName: Constants.images.ellipsis)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color(Constants.color.todo))
                                .frame(width: 25, height: 25)
                            }.buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: self.$editList) {
                            EditList(listIndex: self.editIndex, iconRowIndex: self.todos.todos[self.editIndex].imageRow, iconSectionIndex: self.todos.todos[self.editIndex].imageSection, editList: self.$editList, index: self.$index)
                                .environmentObject(self.todos)
                        }
                    }
                    /// adds a tap gesture to the entire list on an invisible item
                    .background(Color(Constants.color.iconRow).opacity(0.01))
                    .onTapGesture {
                        self.index = self.recreateIndex(id: todoIndex)
                        self.showLists.toggle()

                    }.padding(.vertical, 8)
                }
                .onDelete { index in
                    /// delete pending notifications for this list
                    for todo in self.todos.todos[self.index].todos {
                        if todo.reminderDate.timeIntervalSince(Date()) > 0 {
                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [todo.id])
                            print("Removed Notification \(todo.id) ❌")
                        }
                    }
                    /// if the item we are deleting is the same as the current index + the index is the last possible index and the count is greater than 1, reduce the index by 1. Else, just set it to 0 to be safe.
                    if self.todos.todoListCount() > 1 {
                        self.index = (self.todos.todoListCount() - 1) - 1
                    } else {
                        self.index = 0
                    }
                    self.todos.deleteTodoList(index: self.recreateIndex(id: index.first!))
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.todos.moveList(source: source, destination: destination)
                }
                .listRowBackground(Color(Constants.color.appBG))
            }.onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().backgroundColor = UIColor(named: Constants.color.appBG)
            }
        }.background(Color(Constants.color.appBG))
    }
}

struct ListSelection_Previews: PreviewProvider {
    static var previews: some View {
        ListSelection(index: .constant(0), showLists: .constant(false))
    }
}
