//
//  ListSelection.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct ListSelection: View {
    
    @EnvironmentObject var todos: TodoStore

    @State var addList = false
    @State var listTitle = ""
    @State var editList = false

    @Binding var index: Int
    @Binding var showLists: Bool

    @State var clickedEdit = false

    func todo(todos: Int) -> String {
        if todos >= 0 { return "todos" }
        else { return "todo" }
    }

    var body: some View {
        VStack {
            HStack {
                Text("Lists").font(.largeTitle).bold()
                Spacer()
                Button(action: { self.addList.toggle() }) {
                    ZStack {
                        Color("menuCircle")
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
                    CircleBackground()
                    EditButton()
                        .font(.system(size: 15))
                        .foregroundColor(Constants.mainColor)
                        .onTapGesture {
                            self.clickedEdit.toggle()
                        }
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            List {
                ForEach(self.todos.todos.indices, id: \.self) { todoIndex in
                    HStack {
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
                        VStack {
                            Text(self.todos.todos[todoIndex].title)
                                .font(.system(size: 20, weight: .bold))
                                .padding(.leading, 10)
                                .frame(width: 160, alignment: .leading)
                            Text("\(self.todos.todos[todoIndex].todos.count) \(self.todo(todos: self.todos.todos[todoIndex].todos.count))")
                                .font(.system(size: 13, weight: .medium))
                                .padding(.leading, 10)
                                .frame(width: 160, alignment: .leading)
                                .foregroundColor(.secondary)
                                .padding(.top, 10)
                            Text("Created: \(self.todos.todos[todoIndex].createdAt)")
                                .font(.system(size: 12, weight: .medium))
                                .padding(.leading, 10)
                                .frame(width: 160, alignment: .leading)
                                .foregroundColor(Color.secondary.opacity(0.7))
                                .padding(.top, 3)
                        }
                        Spacer()
                        Button(action: {
                            self.editList.toggle()
                        }) {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color("todoIcon"))
                                .frame(width: 25, height: 25)
                        }
                        .sheet(isPresented: self.$editList) {
                            EditList(listIndex: todoIndex, iconRowIndex: self.todos.todos[todoIndex].imageRow, iconSectionIndex: self.todos.todos[todoIndex].imageSection, editList: self.$editList, index: self.$index)
                                .environmentObject(self.todos)
                        }
                    }
                    .padding(.vertical, 8)
                }.onDelete { index in
                    self.todos.deleteTodoList(index: index.first!)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.todos.todos.move(fromOffsets: source, toOffset: destination)
                    self.todos.saveTodos()
                }
            }
        }
    }
}

struct ListSelection_Previews: PreviewProvider {
    static var previews: some View {
        ListSelection(index: .constant(0), showLists: .constant(false))
    }
}
