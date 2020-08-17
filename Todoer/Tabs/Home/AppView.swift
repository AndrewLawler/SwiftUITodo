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
    
    @State var addedList = false

    @State var index = 0

    @State var showSettings = false
    
    var body: some View {
        VStack {
            HStack {
                Text(todos.todoListCount() == 0 ? "Welcome to Todoer" : todos.todos[index].title).font(.largeTitle).bold()
                Spacer()
                if self.todos.todoListCount() > 1 {
                    Button(action: { self.showLists.toggle() }) {
                        ZStack {
                            Color(#colorLiteral(red: 0.9740100503, green: 0.9682194591, blue: 0.9784608483, alpha: 1))
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Image(systemName: "arrowshape.turn.up.left.fill")
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Constants.mainColor)
                        }
                    }
                    .sheet(isPresented: $showLists) {
                        ListSelection(index: self.$index, showLists: self.$showLists, addedList: self.$addedList)
                            .environmentObject(self.todos)
                    }
                    .padding(.trailing, 10)
                }
                if todos.todoListCount() == 1 {
                    Button(action: { self.addList.toggle() }) {
                        ZStack {
                            Color(#colorLiteral(red: 0.9740100503, green: 0.9682194591, blue: 0.9784608483, alpha: 1))
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            Image(systemName: "book.fill")
                                .frame(width: 20, height: 20)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Constants.mainColor)
                        }
                    }
                    .padding(.trailing, 10)
                    .sheet(isPresented: $addList) {
                        AddList(addList: self.$addList, index: self.$index, addedList: self.$addedList)
                            .environmentObject(self.todos)
                    }
                }
                if todos.todoListCount() > 0 {
                    Button(action: { self.addTodo.toggle() }) {
                        ZStack {
                            Color(#colorLiteral(red: 0.9740100503, green: 0.9682194591, blue: 0.9784608483, alpha: 1))
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
                            Color(#colorLiteral(red: 0.9740100503, green: 0.9682194591, blue: 0.9784608483, alpha: 1))
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
            .padding(.top, 40)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)

            ZStack {
                /// Empty State
                VStack {
                    Spacer()
                    VStack(spacing: 20) {
                        Image(systemName: todos.todoListCount() == 0 ? "book.fill" : "pencil.circle")
                            .resizable()
                            .frame(width: 144, height: 144)
                            .padding(.bottom, 10)
                            .foregroundColor(Constants.mainColor)
                        Text("Oops, I'm Empty!")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(Color(#colorLiteral(red: 0.3137254902, green: 0.3137254902, blue: 0.3137254902, alpha: 1)))
                        Text(todos.todoListCount() == 0 ? "Add a todo list using the\nbutton below." : "Add a todo using the\nbutton below.")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color(#colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                        Button(action: {
                            self.todos.todoListCount() == 0 ? self.addList.toggle() : self.addTodo.toggle()
                        }) {
                            ZStack {
                                Constants.mainColor
                                    .frame(width: 107, height: 37)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .semibold))
                            }
                        }
                        .sheet(isPresented: self.todos.todoListCount() == 0 ? $addList : $addTodo) {
                            if self.addList {
                                AddList(addList: self.$addList, index: self.$index, addedList: self.$addedList)
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
                    ListView(index: self.$index, editTodo: self.$editTodo)
                        .environmentObject(self.todos)
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
        Color(#colorLiteral(red: 0.9740100503, green: 0.9682194591, blue: 0.9784608483, alpha: 1))
            .frame(width: 40, height: 40)
            .clipShape(Circle())
    }
}

struct ListView: View {

    @EnvironmentObject var todos: TodoStore
    @Binding var index: Int
    @Binding var editTodo: Bool

    var body: some View {
        List {
            ForEach(self.todos.todos[index].todos.indices, id: \.self) { todoIndex in
                HStack {
                    ZStack {
                        Constants.mainColor
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    }.onTapGesture {
                        self.todos.todos[self.index].todos.remove(at: todoIndex)
                    }
                    .frame(width: 25, height: 25)
                    .padding(.leading, 10)

                    ZStack {
                        Color(#colorLiteral(red: 0.9740100503, green: 0.9682194591, blue: 0.9784608483, alpha: 1))
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                        Image(systemName: Constants.icons[self.todos.todos[self.index].todos[todoIndex].image].name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 27, height: 27)
                            .foregroundColor(Constants.mainColor)
                    }

                    Text(self.todos.todos[self.index].todos[todoIndex].content)
                        .fontWeight(.medium)
                        .padding(.leading, 10)
                        .font(.system(size: 17))

                    Spacer()

                    Button(action: {
                        self.editTodo.toggle()
                    }) {
                        ZStack {
                            Constants.mainColor
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        }
                    }
                    .frame(width: 25, height: 25)
                    .sheet(isPresented: self.$editTodo) {
                        EditTodo(todoIndex: todoIndex, editTodo: self.$editTodo, index: self.$index)
                            .environmentObject(self.todos)
                    }
                    .padding(.trailing, 10)
                }
            }
            .onDelete { index in
                self.todos.todos[self.index].todos.remove(at: index.first!)
            }
            .onMove { (source: IndexSet, destination: Int) in
                self.todos.todos[self.index].todos.move(fromOffsets: source, toOffset: destination)
            }
        }
    }
}
