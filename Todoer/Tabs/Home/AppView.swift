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
                    Text(Constants.welcome.title).font(.largeTitle).bold()
                        .padding(.top, 90)
                } else {
                    Text(todos.todos[index].title)
                        .font(.largeTitle).bold()
                        .foregroundColor(Color.primary)
                        .multilineTextAlignment(.center)
                        .padding(.top, DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Standard ? 30 : 75)
                }
            }
            .padding(.bottom, DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Standard ? 10 : 35)
            .padding(.horizontal, 20)
            
            HStack {
                if todos.todoListCount() >= 1 {
                    Button(action: { self.showLists.toggle() }) {
                        ZStack {
                            Color(Constants.color.darkMenuCircle)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
                            Image(systemName: Constants.images.menuArrow)
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                    }
                    .sheet(isPresented: $showLists) {
                        ListSelection(index: self.$index, showLists: self.$showLists)
                            .environmentObject(self.todos)
                    }
                    .padding(.trailing, 10)
                }

                if todos.todoListCount() > 0 {
                    Button(action: { self.editList.toggle() }) {
                        ZStack {
                            Color(Constants.color.darkMenuCircle)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
                            Image(systemName: Constants.images.edit)
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                    }
                    .sheet(isPresented: $editList) {
                        EditList(listIndex: self.index, iconRowIndex: self.todos.todos[self.index].imageRow, iconSectionIndex: self.todos.todos[self.index].imageSection, editList: self.$editList, index: self.$index)
                            .environmentObject(self.todos)
                    }
                    .padding(.trailing, 10)

                    Button(action: { self.addList.toggle() }) {
                        ZStack {
                            Color(Constants.color.darkMenuCircle)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
                            Image(systemName: Constants.images.list)
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                    }
                    .sheet(isPresented: $addList) {
                        AddList(addList: self.$addList, index: self.$index)
                            .environmentObject(self.todos)
                    }
                    .padding(.trailing, 10)

                    Button(action: { self.addTodo.toggle() }) {
                        ZStack {
                            Color(Constants.color.darkMenuCircle)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
                            Image(systemName: Constants.images.plus)
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                    }
                    .sheet(isPresented: $addTodo) {
                        AddTodo(index: self.$index, addTodo: self.$addTodo)
                            .environmentObject(self.todos)
                    }
                    .padding(.trailing, 10)

                    if !(todos.todos[index].todos.isEmpty ) {
                        ZStack {
                            Color(Constants.color.darkMenuCircle)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
                            EditButton()
                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                        .padding(.trailing, 10)
                    }

                    Button(action: { self.showSettings.toggle() }) {
                        ZStack {
                            Color(Constants.color.darkMenuCircle)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 0)
                            Image(systemName: Constants.images.settings)
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                    }
                    .sheet(isPresented: $showSettings) {
                        Settings(showSettings: self.$showSettings)
                            .environmentObject(self.todos)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .padding(.horizontal, 20)
            .padding(.top, 10)
            .padding(.bottom, todos.todoListCount() == 0 ? 0 : 10)
            .frame(width: UIScreen.main.bounds.width - 20)
            .background(Color(todos.todoListCount() == 0 ? Constants.color.appBG : Constants.color.menuTab))
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .padding(.bottom, todos.todoListCount() == 0 ? 0 : 10)

            ZStack {
                /// Empty State
                VStack {
                    Spacer()
                    VStack(spacing: 20) {
                        Image(systemName: todos.todoListCount() == 0 ? Constants.images.list : Constants.images.plusCircle)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 144, height: 144)
                            .padding(.bottom, 30)
                            .foregroundColor(Color(Constants.mainColor))
                        Text(Constants.emptyState.title)
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(Color(Constants.color.emptyTitle))
                            .padding(.bottom, 10)
                        Text(todos.todoListCount() == 0 ? Constants.emptyState.listSubTitle : Constants.emptyState.todoSubtitle)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color(#colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                        Button(action: {
                            self.todos.todoListCount() == 0 ? self.addList.toggle() : self.addTodo.toggle()
                        }) {
                            ZStack {
                                Color(Constants.mainColor)
                                    .frame(width: 107, height: 43)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                Image(systemName: Constants.images.plus)
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
                            VStack(spacing: 10) {
                                HStack {
                                    ZStack {
                                        Color(Constants.color.todoBG)
                                            .frame(width: 25, height: 25)
                                            .clipShape(Circle())
                                        Image(systemName: Constants.images.checkmark)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(Color(Constants.mainColor))
                                    }.onTapGesture {
                                        withAnimation(.easeOut) {
                                            self.todos.deleteTodo(index: self.index, todoIndex: todoIndex)
                                        }
                                    }
                                    .frame(width: 25, height: 25)
                                    .padding(.leading, 10)

                                    ZStack {
                                        Color(Constants.color.todoBG)
                                            .frame(width: 30, height: 30)
                                            .clipShape(Circle())
                                        Image(systemName: Constants.iconsOrdered[self.todos.todos[self.index].todos[todoIndex].imageSection].icons[self.todos.todos[self.index].todos[todoIndex].imageRow].systemName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 17, height: 17)
                                            .foregroundColor(Color(Constants.mainColor))
                                    }.padding(.leading, 5)

                                    Text(self.todos.todos[self.index].todos[todoIndex].content)
                                        .fontWeight(.medium)
                                        .padding(.leading, 10)
                                        .font(.callout)

                                    Spacer()

                                    Button(action: {
                                        self.indexOfTodo = todoIndex
                                        self.editTodo.toggle()
                                    }) {
                                        ZStack {
                                            Color("oppositeColor")
                                                .frame(width: 30, height: 30)
                                            Image(systemName: Constants.images.ellipsis)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 13, height: 13)
                                                .foregroundColor(Color(Constants.color.todo))
                                                .padding(.horizontal, 10)
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .sheet(isPresented: self.$editTodo) {
                                        EditTodo(todoIndex: self.indexOfTodo,
                                                 iconRowIndex: self.todos.todos[self.index].todos[self.indexOfTodo].imageRow,
                                                 iconSectionIndex: self.todos.todos[self.index].todos[self.indexOfTodo].imageSection,
                                                 editTodo: self.$editTodo,
                                                 index: self.$index)
                                            .environmentObject(self.todos)
                                    }
                                }
                                /// sub todos
                                if self.todos.todos[self.index].todos[todoIndex].subTodos.count > 0 {
                                    HStack {
                                        VStack {
                                            ForEach(self.todos.todos[self.index].todos[todoIndex].subTodos.indices, id:     \.self) { subTodoIndex in
                                                HStack {
                                                    Image(systemName: Constants.images.bulletList)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 14, height: 14)
                                                        .foregroundColor(Color(Constants.color.todo))
                                                        .padding(.leading, 12)
                                                    ZStack {
                                                        Color(Constants.color.todoBG)
                                                            .frame(width: 25, height: 25)
                                                            .clipShape(Circle())
                                                        Image(systemName: Constants.images.checkmark)
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 15, height: 15)
                                                            .foregroundColor(Color(Constants.mainColor))
                                                    }
                                                    .onTapGesture {
                                                        withAnimation(.easeOut) {
                                                            self.todos.deleteSubTodo(index: self.index, todoIndex:  todoIndex, subTodoIndex: subTodoIndex)
                                                        }
                                                    }
                                                    .frame(width: 25, height: 25)
                                                    .padding(.horizontal, 10)

                                                    Text(self.todos.todos[self.index].todos[todoIndex].subTodos [subTodoIndex].content)
                                                        .fontWeight(.regular)
                                                        .font(.caption)

                                                    Spacer()

                                                    Button(action: {
                                                        self.indexOfTodo = todoIndex
                                                        self.indexOfSubTodo = subTodoIndex
                                                        self.editSubTodo.toggle()
                                                    }) {
                                                        ZStack {
                                                            Color("oppositeColor")
                                                                .frame(width: 30, height: 30)
                                                            Image(systemName: Constants.images.ellipsis)
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 13, height: 13)
                                                                .foregroundColor(Color(Constants.color.todo))
                                                                .padding(.horizontal, 10)
                                                        }
                                                    }.buttonStyle(PlainButtonStyle())
                                                    .sheet(isPresented: self.$editSubTodo) {
                                                        EditSubTodo(todoIndex: self.indexOfTodo, subTodoIndex:  self.indexOfSubTodo, editSubTodo: self.$editSubTodo, index:     self.$index)
                                                            .environmentObject(self.todos)
                                                    }
                                                }
                                            }
                                        }.padding(.leading, 45)
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 17)
                            .background(Color("oppositeColor"))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 0)
                        }
                        .onDelete { index in
                            withAnimation(.easeOut) {
                                self.todos.deleteTodo(index: self.index, todoIndex: index.first!)
                            }
                        }
                        .onMove { (source: IndexSet, destination: Int) in
                            withAnimation(.easeOut) {
                                self.todos.moveTodo(index: self.index, source: source, destination: destination)
                            }
                        }
                        .listRowBackground(Color(Constants.color.appBG))
                    }.onAppear {
                        UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().backgroundColor = UIColor(named: Constants.color.appBG)
                    }
                    .padding(.top, 10)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(Constants.color.appBG))
        .edgesIgnoringSafeArea(.all)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
