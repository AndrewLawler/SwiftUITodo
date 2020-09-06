//
//  AddList.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

/// Custom view to add a list to the todo store

struct AddList: View {

    @EnvironmentObject var todos: TodoStore

    @State var listTitle = ""
    @State var listIcon = 0

    @Binding var addList: Bool
    @Binding var index: Int

    @State var selectedIconSectionIndex = 0
    @State var selectedIconRowIndex = 0

    /// formatter to take the date created and transform it

    let createdDay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    /// placeholder which can be updated throughout if needed
    @State var textfieldPlaceholder = "Please enter list title"

    var body: some View {
        NavigationView {
            /// list showing options in menu format
            List {
                Section(header: Text("Title")) {
                    TextField(textfieldPlaceholder, text: $listTitle)
                        .foregroundColor(.primary)
                        .accentColor(Color(Constants.mainColor))
                }
                Section(header: Text("Icon")) {
                    NavigationLink(destination: IconChoice(selectedIconRowIndex: $selectedIconRowIndex, selectedIconSectionIndex: $selectedIconSectionIndex)) {
                        HStack {
                            Text("Please select an icon")
                                .foregroundColor(Color.primary)
                            Spacer()
                            Image(systemName: Constants.iconsOrdered[self.selectedIconSectionIndex].icons[self.selectedIconRowIndex].systemName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Create List")
            .navigationBarItems(leading: Button(action: { self.addList.toggle() }) {
                Text("Cancel")
                    .foregroundColor(Color(Constants.mainColor))
                }, trailing: Button(action: {
                    /// if we are empty to not create a todo, instead just change the textfield placeholder to request something
                    if self.listTitle != "" {
                        self.todos.createTodoList(title: self.listTitle, imageSection: self.selectedIconSectionIndex, imageRow: self.selectedIconRowIndex ,createdAt: self.createdDay.string(from: Date()))
                        if self.todos.todoListCount() > 1 {
                            let count = self.todos.todoListCount()
                            self.index = count - 1
                        }
                        self.listIcon = 0
                        self.listTitle = ""
                        self.addList.toggle()
                    } else {
                        self.textfieldPlaceholder = "Please add a list title"
                    }
                }) {
                    Text("Done").bold()
                        .foregroundColor(Color(Constants.mainColor))
                })
        }
    }
}

struct AddList_Previews: PreviewProvider {
    static var previews: some View {
        AddList(listTitle: "", listIcon: 0, addList: .constant(false), index: .constant(0))
    }
}

