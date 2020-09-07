//
//  AppView.swift
//  Todoer
//
//  Created by Andrew Lawler on 17/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI
import UserNotifications

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

    func getAppIcon() -> String {
        let iconName = UIApplication.shared.alternateIconName ?? "Primary"
        if iconName == "Primary" {
            return "1"
        } else if iconName == "AppIconTwo" {
            return "2"
        } else if iconName == "Classic" {
            return "3"
        } else if iconName == "Red" {
            return "4"
        } else if iconName == "GreenBlue" {
            return "5"
        } else if iconName == "RedBlue" {
            return "6"
        }
        return "1"
    }

    let notificationDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = ""
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    /// need logic for gapFromTop using device type of less than iphone 8
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 30) {
                if todos.todoListCount() == 0 {
                    Text(Constants.welcome.title).font(.largeTitle).bold()
                        .padding(.top, DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Standard ? 70 : 120)
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
                            Image(systemName: Constants.images.list)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
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
                                .resizable()
                                .aspectRatio(contentMode: .fit)
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
                            Image(systemName: Constants.images.addList)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
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
                                .resizable()
                                .aspectRatio(contentMode: .fit)
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
                                .resizable()
                                .aspectRatio(contentMode: .fit)
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
                    VStack(spacing: 20) {
                        Image(getAppIcon())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170, height: 170)
                            .cornerRadius(30)
                            .padding(.bottom, 50)
                        VStack(spacing: 30) {
                           Text("Organise your tasks")
                                .font(.system(size: 30, weight: .semibold))
                                .foregroundColor(Color(Constants.color.emptyTitle))
                                .multilineTextAlignment(.center)
                           Text("Tap below to create your very\nfirst list!")
                                .font(.system(size: 18, weight: .regular))
                                .foregroundColor(Color(#colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)))
                                .multilineTextAlignment(.center)
                        }.padding(.bottom, 40)
                        Button(action: {
                            self.addList.toggle()
                        }) {
                            ZStack {
                                Color(Constants.mainColor)
                                    .frame(width: 145, height: 43)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                Image(systemName: Constants.images.addList)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20, weight: .semibold))
                            }
                        }
                        .sheet(isPresented: self.todos.todoListCount() == 0 ? $addList : $addTodo) {
                            AddList(addList: self.$addList, index: self.$index)
                                .environmentObject(self.todos)
                        }
                    }
                    Spacer()
                    Spacer()
                }
                .offset(y: todos.todoListCount() == 0 ? 0 : UIScreen.main.bounds.height + 100)
                .animation(.easeInOut)

                VStack {
                    Spacer()
                    VStack(spacing: 20) {
                        Image(systemName: Constants.images.plusCircle)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 144, height: 144)
                            .padding(.bottom, 30)
                            .foregroundColor(Color(Constants.mainColor))
                        Text(Constants.emptyState.title)
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(Color(Constants.color.emptyTitle))
                            .padding(.bottom, 10)
                        Text(Constants.emptyState.todoSubtitle)
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(Color(#colorLiteral(red: 0.6862745098, green: 0.6862745098, blue: 0.6862745098, alpha: 1)))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                        Button(action: {
                            self.addTodo.toggle()
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
                            AddTodo(index: self.$index, addTodo: self.$addTodo)
                                .environmentObject(self.todos)
                        }
                    }
                    Spacer()
                    Spacer()
                }
                .offset(y: todos.todoListCount() != 0 ? 0 : UIScreen.main.bounds.height + 100)
                .animation(.easeInOut)

                /// List View
                /// todos
                if self.todos.todoCount(index: index) != 0 {
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

                                    if self.todos.todos[self.index].todos[todoIndex].notificationState && self.todos.todos[self.index].todos[todoIndex].reminderDate.timeIntervalSince(Date()) > 0 {
                                        Text(self.notificationDate.string(from: self.todos.todos[self.index].todos[todoIndex].reminderDate))
                                            .fontWeight(.medium)
                                            .font(.caption)
                                            .padding(.leading, 10)
                                            .foregroundColor(Color("timeLabel"))
                                    }
                                    
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
                                /// remove notification if there is one
                                print("⏱ \(self.todos.todos[self.index].todos[index.first!].reminderDate.timeIntervalSince(Date()))")
                                if self.todos.todos[self.index].todos[index.first!].reminderDate.timeIntervalSince(Date()) > 0 {
                                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.todos.todos[self.index].todos[index.first!].id])
                                    print("Removed Notification \(self.todos.todos[self.index].todos[index.first!].id) ❌")
                                }
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
        .onAppear {
            let id = UserDefaults.standard.integer(forKey: "setNotifications")
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge]) { success, error in
                if success {
                    if id != 1 {
                        print("Notification Permissions Granted 😀")
                        UserDefaults.standard.set(1, forKey: "notifications")
                        UserDefaults.standard.set(1, forKey: "setNotifications")
                    }
                } else if let error = error {
                    print(error.localizedDescription)
                    if id != 1 {
                        UserDefaults.standard.set(0, forKey: "notifications")
                        UserDefaults.standard.set(1, forKey: "setNotifications")
                    }
                }
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
