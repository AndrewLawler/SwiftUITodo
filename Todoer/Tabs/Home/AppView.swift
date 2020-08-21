//
//  AppView.swift
//  Todoer
//
//  Created by Andrew Lawler on 17/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct AppView: View {

    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var todos: TodoStore

    @State var showLists = false
    @State var addList = false
    @State var editList = false

    @State var addTodo = false
    @State var editTodo = false

    @State var editSubTodo = false

    @State var indexOfTodo = 0
    @State var indexOfSubTodo = 0

    @State var index = 0

    @State var showSettings = false

    /// need logic for gapFromTop using device type of less than iphone 8
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 30) {
                if todos.todoListCount() == 0 {
                    Text("Welcome to Todoer").font(.largeTitle).bold()
                        .padding(.top, 90)
                } else {
                    Text(todos.todos[index].title)
                        .font(.largeTitle).bold()
                        .foregroundColor(Color.primary)
                        .multilineTextAlignment(.center)
                        .padding(.top, DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Standard ? 30 : 70)
                }
            }
            .padding(.bottom, DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Standard ? 10 : 35)
            .padding(.horizontal, 20)
            
            HStack {
                if todos.todoListCount() == 1 && todos.todoCount(index: index) >= 1 {
                    Button(action: { self.showLists.toggle() }) {
                        ZStack {
                            Color("darkModeMenuCircle")
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
                    }.padding(.trailing, 10)
                    
                }

                if todos.todoListCount() > 0 {
                    Button(action: { self.editList.toggle() }) {
                        ZStack {
                            Color("darkModeMenuCircle")
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
                    }.padding(.trailing, 10)

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
                    }

                    Button(action: { self.addTodo.toggle() }) {
                        ZStack {
                            Color("darkModeMenuCircle")
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
                            Color("darkModeMenuCircle")
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            EditButton()
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Constants.mainColor)
                        }.padding(.trailing, 10)
                    }

                    Button(action: { self.showSettings.toggle() }) {
                        ZStack {
                            Color("darkModeMenuCircle")
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
            .frame(height: 40)
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, todos.todoListCount() == 0 ? 0 : 10)
            .frame(width: UIScreen.main.bounds.width - 20)
            .background(Color(todos.todoListCount() == 0 ? "appBackground" : "menuTabBar"))
            .clipShape(RoundedRectangle(cornerRadius: 30))

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
                    /// todos
                    List {
                        ForEach(self.todos.todos[index].todos.indices, id: \.self) { todoIndex in
                            VStack {
                                HStack {
                                    ZStack {
                                        Color("todoIconBackground")
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
                                        Color("todoIconBackground")
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
                                        .font(.body)

                                    Spacer()

                                    Button(action: {
                                        self.indexOfTodo = todoIndex
                                        self.editTodo.toggle()
                                    }) {
                                        Image(systemName: "ellipsis")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 13, height: 13)
                                            .foregroundColor(Color("todoIcon"))
                                            .padding(.horizontal, 10)
                                    }.buttonStyle(PlainButtonStyle())
                                    .sheet(isPresented: self.$editTodo) {
                                        EditTodo(todoIndex: self.indexOfTodo,
                                                 iconRowIndex: self.todos.todos[self.index].todos[self.indexOfTodo].imageRow,
                                                 iconSectionIndex: self.todos.todos[self.index].todos[self.indexOfTodo].imageSection,
                                                 editTodo: self.$editTodo,
                                                 index: self.$index)
                                            .environmentObject(self.todos)
                                    }.frame(width: 30, height: 30)
                                }

                                /// sub todos

                                HStack {
                                    VStack {
                                        ForEach(self.todos.todos[self.index].todos[todoIndex].subTodos.indices, id: \.self) { subTodoIndex in
                                            HStack {
                                                Image(systemName: "list.bullet")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 14, height: 14)
                                                    .foregroundColor(Color("todoIcon"))
                                                    .padding(.leading, 12)

                                                ZStack {
                                                    Color("todoIconBackground")
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
                                                    .font(.caption)

                                                Spacer()
                                                Spacer()

                                                Button(action: {
                                                    self.indexOfTodo = todoIndex
                                                    self.indexOfSubTodo = subTodoIndex
                                                    self.editSubTodo.toggle()
                                                }) {
                                                    Image(systemName: "ellipsis")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 13, height: 13)
                                                        .foregroundColor(Color("todoIcon"))
                                                }.buttonStyle(PlainButtonStyle())
                                                .sheet(isPresented: self.$editSubTodo) {
                                                    EditSubTodo(todoIndex: self.indexOfTodo, subTodoIndex: self.indexOfSubTodo, editSubTodo: self.$editSubTodo, index: self.$index)
                                                        .environmentObject(self.todos)
                                                }.padding(.horizontal, 10)
                                                .frame(width: 30, height: 30)
                                            }
                                        }
                                    }.padding(.leading, 45)
                                }
                            }
                            .padding(.vertical, 7)
                        }
                        .onDelete { index in
                            self.todos.deleteTodo(index: self.index, todoIndex: index.first!)
                        }
                        .onMove { (source: IndexSet, destination: Int) in
                            self.todos.todos[self.index].todos.move(fromOffsets: source, toOffset: destination)
                            self.todos.saveTodos()
                        }
                        .listRowBackground(Color("appBackground"))
                    }.onAppear {
                        UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().backgroundColor = UIColor(named: "appBackground")
                    }
                    .padding(.top, 10)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .background(Color("appBackground"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
