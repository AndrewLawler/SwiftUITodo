//
//  AppView.swift
//  Todoer
//
//  Created by Andrew Lawler on 17/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct AppView: View {

    @EnvironmentObject var todos: TodoStore

    @State var showLists = false
    @State var addList = false
    @State var addTodo = false
    @State var editTodo = false
    @State var editList = false
    @State var editSubTodo = false

    @State var index = 0

    @State var showSettings = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if todos.todoListCount() == 0 {
                    Text("Welcome to Todoer").font(.largeTitle).bold()
                        .padding(.top, 50)
                } else {
                    Text(todos.todos[index].title)
                    	.font(.largeTitle).bold()
                    	.foregroundColor(Color.primary)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
            
            HStack {
                if todos.todoListCount() != 0 {
                    Button(action: { self.editList.toggle() }) {
                        ZStack {
                            Color("menuCircle")
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Image(systemName: "pencil")
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Constants.mainColor)
                        }
                    }
                    .sheet(isPresented: $editList) {
                        EditList(listIndex: self.index, iconRowIndex: self.todos.todos[self.index].imageRow, iconSectionIndex: self.todos.todos[self.index].imageSection, editList: self.$editList, index: self.$index)
                            .environmentObject(self.todos)
                    }
                }
                Spacer()
                if todos.todoListCount() > 0 {
                    Button(action: { self.showLists.toggle() }) {
                        ZStack {
                            Color("menuCircle")
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Image(systemName: "arrowshape.turn.up.left.fill")
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Constants.mainColor)
                        }
                    }
                    .sheet(isPresented: $showLists) {
                        ListSelection(index: self.$index, showLists: self.$showLists)
                            .environmentObject(self.todos)
                    }
                    .padding(.trailing, 10)

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
                    }

                    Button(action: { self.addTodo.toggle() }) {
                        ZStack {
                            Color("menuCircle")
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Image(systemName: "plus")
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Constants.mainColor)
                        }
                    }
                    .padding(.trailing, 10)
                    .sheet(isPresented: $addTodo) {
                        AddTodo(index: self.$index, addTodo: self.$addTodo)
                            .environmentObject(self.todos)
                    }
                    if !(todos.todos[index].todos.isEmpty ) {
                        ZStack {
                            CircleBackground()
                            EditButton()
                                .font(.system(size: 15))
                                .foregroundColor(Constants.mainColor)
                        }.padding(.trailing, 10)
                    }
                    Button(action: { self.showSettings.toggle() }) {
                        ZStack {
                            Color("menuCircle")
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Image(systemName: "gear")
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Constants.mainColor)
                        }
                    }.sheet(isPresented: $showSettings) {
                        Settings(showSettings: self.$showSettings)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .padding(.horizontal, 20)
            .padding(.bottom, todos.todoListCount() == 0 ? 0 : 20)

            ZStack {
                /// Empty State
                VStack {
                    Spacer()
                    VStack(spacing: 20) {
                        Image(systemName: todos.todoListCount() == 0 ? "doc.text.fill" : "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 144, height: 144)
                            .padding(.bottom, 30)
                            .foregroundColor(Constants.mainColor)
                        Text("Oops, I'm Empty!")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(Color("emptyStateTitle"))
                            .padding(.bottom, 10)
                        Text(todos.todoListCount() == 0 ? "Add a todo list using the\nbutton below." : "Add a todo using the\nbutton below.")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color(#colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                        Button(action: {
                            self.todos.todoListCount() == 0 ? self.addList.toggle() : self.addTodo.toggle()
                        }) {
                            ZStack {
                                Constants.mainColor
                                    .frame(width: 107, height: 43)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .semibold))
                            }
                        }
                        .sheet(isPresented: self.todos.todoListCount() == 0 ? $addList : $addTodo) {
                            if self.addList {
                                AddList(addList: self.$addList, index: self.$index)
                                    .environmentObject(self.todos)
                            } else if self.addTodo {
                                AddTodo(index: self.$index, addTodo: self.$addTodo)
                                    .environmentObject(self.todos)
                            }
                        }
                    }
                    Spacer()
                    Spacer()
                }

                /// List View
                if self.todos.todoCount(index: index) != 0 {
                    List {
                        ForEach(self.todos.todos[index].todos.indices, id: \.self) { todoIndex in
                            VStack {
                                HStack {
                                    ZStack {
                                        Color("menuCircle")
                                            .frame(width: 30, height: 30)
                                            .clipShape(Circle())
                                        Image(systemName: "checkmark.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 18, height: 18)
                                            .foregroundColor(Constants.mainColor)
                                    }.onTapGesture {
                                        self.todos.deleteTodo(index: self.index, todoIndex: todoIndex)
                                    }
                                    .frame(width: 25, height: 25)
                                    .padding(.leading, 10)

                                    ZStack {
                                        Color("menuCircle")
                                            .frame(width: 30, height: 30)
                                            .clipShape(RoundedRectangle(cornerRadius: 5))
                                        Image(systemName: Constants.iconsOrdered[self.todos.todos[self.index].todos[todoIndex].imageSection].icons[self.todos.todos[self.index].todos[todoIndex].imageRow].systemName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 18, height: 18)
                                            .foregroundColor(Constants.mainColor)
                                    }.padding(.leading, 5)

                                    Text(self.todos.todos[self.index].todos[todoIndex].content)
                                        .fontWeight(.medium)
                                        .padding(.leading, 10)
                                        .font(.system(size: 17))

                                    Spacer()

                                    Button(action: {
                                        print("Tapped todo elipsis")
                                    }) {
                                        Image(systemName: "ellipsis")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 13, height: 13)
                                            .foregroundColor(Color("todoIcon"))
                                    }.sheet(isPresented: self.$editTodo) {
                                        EditTodo(todoIndex: todoIndex, iconRowIndex: self.todos.todos[self.index].todos[todoIndex].imageRow, iconSectionIndex: self.todos.todos[self.index].todos[todoIndex].imageSection, editTodo: self.$editTodo, index: self.$index)
                                            .environmentObject(self.todos)
                                    }
                                    .padding(.horizontal, 10)
                                }.onTapGesture {
                                    self.editTodo.toggle()
                                }

                                HStack {
                                    VStack {
                                        ForEach(self.todos.todos[self.index].todos[todoIndex].subTodos.indices, id: \.self) { subTodoIndex in
                                            HStack {
                                                Image(systemName: "list.bullet")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 15, height: 15)
                                                    .foregroundColor(Color("todoIcon"))
                                                    .padding(.leading, 10)

                                                ZStack {
                                                    Color("menuCircle")
                                                        .frame(width: 25, height: 25)
                                                        .clipShape(Circle())
                                                    Image(systemName: "checkmark.circle")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 15, height: 15)
                                                        .foregroundColor(Constants.mainColor)
                                                }
                                                .onTapGesture {
                                                    self.todos.deleteSubTodo(index: self.index, todoIndex: todoIndex, subTodoIndex: subTodoIndex)
                                                }
                                                .frame(width: 25, height: 25)
                                                .padding(.horizontal, 10)

                                                Text(self.todos.todos[self.index].todos[todoIndex].subTodos[subTodoIndex].content)
                                                    .fontWeight(.regular)
                                                    .font(.system(size: 13))

                                                Spacer()
                                                Spacer()

                                                Button(action: {
                                                    print("Tapped sub todo elipsis")
                                                }) {
                                                    Image(systemName: "ellipsis")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 13, height: 13)
                                                        .foregroundColor(Color("todoIcon"))
                                                }
                                                .sheet(isPresented: self.$editSubTodo) {
                                                    EditSubTodo(todoIndex: todoIndex, subTodoIndex: subTodoIndex, editSubTodo: self.$editSubTodo, index: self.$index)
                                                        .environmentObject(self.todos)
                                                }
                                                .padding(.horizontal, 10)
                                            }
                                        }
                                    }.padding(.leading, 45)
                                        .onTapGesture {
                                            self.editSubTodo.toggle()
                                        }
                                }

                            }
                        }
                        .onDelete { index in
                            self.todos.deleteTodo(index: self.index, todoIndex: index.first!)
                        }
                        .onMove { (source: IndexSet, destination: Int) in
                            self.todos.todos[self.index].todos.move(fromOffsets: source, toOffset: destination)
                            self.todos.saveTodos()
                        }
                    }
                }
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}

struct CircleBackground: View {
    var body: some View {
        Color("menuCircle")
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}
