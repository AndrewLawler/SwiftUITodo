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

    /// get the correct string needed for the todo
    func todoText(todos: Int) -> String {
        if todos >= 0 { return "todos" }
        else { return "todo" }
    }

    /// get the correct string needed for the sub todo
    func subTodoText(todos: Int) -> String {
        if todos >= 0 { return "sub todos" }
        else { return "sub todo" }
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
                Text("Lists").font(.largeTitle).bold()
                Spacer()
                /// HStack of the two buttons used in the view
                HStack {
                    Button(action: { self.addList.toggle() }) {
                        ZStack {
                            Color("darkModeMenuCircle")
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Image(systemName: "doc.text.fill")
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Constants.mainColor)
                        }
                    }
                    .padding(.trailing, 10)
                    .sheet(isPresented: $addList) {
                        AddList(addList: self.$addList, index: self.$index)
                            .environmentObject(self.todos)
                    }.padding(.trailing, 10)
                    ZStack {
                        Color("darkModeMenuCircle")
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                        EditButton()
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Constants.mainColor)
                            .onTapGesture {
                                self.clickedEdit.toggle()
                            }
                    }
                }
                /// adds a ring around the menu items in dark mode
                .frame(width: 135)
                .frame(height: 60)
                .background(Color("menuTabBar"))
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
                            Constants.mainColor
                                .frame(width: 80, height: 80)
                                .cornerRadius(20)
                            Image(systemName: Constants.iconsOrdered[self.todos.todos[todoIndex].imageSection].icons[self.todos.todos[todoIndex].imageRow].systemName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.white)
                        }.frame(width: 80, height: 80)
                        .onTapGesture {
                            self.index = todoIndex
                            self.showLists.toggle()
                        }
                        /// text with title, todos and creation date
                        VStack {
                            Text(self.todos.todos[todoIndex].title)
                                .font(.system(size: 20, weight: .bold))
                                .padding(.leading, 10)
                                .frame(width: 150, alignment: .leading)
                            Text("\(self.todos.todos[todoIndex].todos.count) \(self.todoText(todos: self.todos.todos[todoIndex].todos.count)), \(self.calculateSubTodo(listIndex: todoIndex)) \(self.subTodoText(todos: self.calculateSubTodo(listIndex: todoIndex)))")
                                .font(.system(size: 13, weight: .medium))
                                .padding(.leading, 10)
                                .frame(width: 150, alignment: .leading)
                                .foregroundColor(.secondary)
                                .padding(.top, 10)
                            Text("Created: \(self.todos.todos[todoIndex].createdAt)")
                                .font(.system(size: 12, weight: .medium))
                                .padding(.leading, 10)
                                .frame(width: 150, alignment: .leading)
                                .foregroundColor(Color.secondary.opacity(0.7))
                                .padding(.top, 3)
                        }

                        Spacer()

                        /// more button to edit the list
                        Button(action: {
                            self.editIndex = todoIndex
                            self.editList.toggle()
                        }) {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("todoIcon"))
                                .frame(width: 25, height: 25)
                            }.buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: self.$editList) {
                            EditList(listIndex: self.editIndex, iconRowIndex: self.todos.todos[self.editIndex].imageRow, iconSectionIndex: self.todos.todos[self.editIndex].imageSection, editList: self.$editList, index: self.$index)
                                .environmentObject(self.todos)
                        }
                    }
                    /// adds a tap gesture to the entire list on an invisible item
                    .background(Color("iconSelectionRow").opacity(0.01))
                    .onTapGesture {
                        self.index = todoIndex
                        self.showLists.toggle()

                    }.padding(.vertical, 8)
                }
                .onDelete { index in
                    /// if the item we are deleting is the same as the current index + the index is the last possible index and the count is greater than 1, reduce the index by 1. Else, just set it to 0 to be safe.
                    if self.index == index.first && self.index == self.todos.todoListCount() - 1 && self.todos.todoListCount() > 1 {
                        self.index = self.index - 1
                    } else {
                        self.index = 0
                    }
                    self.todos.deleteTodoList(index: index.first!)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.todos.todos.move(fromOffsets: source, toOffset: destination)
                    self.todos.saveTodos()
                }
                .listRowBackground(Color("appBackground"))
            }
        }.background(Color("appBackground"))
    }
}

struct ListSelection_Previews: PreviewProvider {
    static var previews: some View {
        ListSelection(index: .constant(0), showLists: .constant(false))
    }
}
