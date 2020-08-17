//
//  AddList.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct AddList: View {

    @EnvironmentObject var todos: TodoStore

    @State var listTitle = ""
    @State var listIcon = 0

    @Binding var addList: Bool
    @Binding var index: Int
    @Binding var addedList: Bool

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("List Title")) {
                    TextField("List Title", text: $listTitle)
                        .foregroundColor(.black)
                        .accentColor(Constants.mainColor)
                        .background(Color.white)
                }
                Section(header: Text("Select Icon")) {
                    Picker(selection: $listIcon, label: Text("Please choose an icon")) {
                        ForEach(0 ..< Constants.icons.count) {
                            Image(systemName: "\(Constants.icons[$0].name)")
                                .foregroundColor(Constants.mainColor)
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Create List")
            .navigationBarItems(leading: Button(action: { self.addList.toggle() }) {
                Text("Cancel")
            }, trailing: Button(action: {
                if !self.listTitle.isEmpty {
                    self.todos.createTodoList(title: self.listTitle, image: self.listIcon)
                    if self.todos.todoListCount() > 1 { self.index = self.index + 1 }
                    self.addedList.toggle()
                }
                self.listIcon = 0
                self.listTitle = ""
                self.addList.toggle()
            }) {
                Text("Done").bold()
            })
        }
    }
}

struct AddList_Previews: PreviewProvider {
    static var previews: some View {
        AddList(listTitle: "", listIcon: 0, addList: .constant(false), index: .constant(0), addedList: .constant(false))
    }
}

