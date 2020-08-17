//
//  EditList.swift
//  Todoer
//
//  Created by Andrew Lawler on 17/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct EditList: View {

    @EnvironmentObject var todos: TodoStore
    
    var listIndex: Int

    @Binding var editList: Bool
    @Binding var index: Int

    @State var listTitle = ""
    @State var listIcon = 0

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Edit Title")) {
                    TextField(todos.todos[listIndex].title, text: $listTitle)
                        .foregroundColor(.black)
                        .accentColor(Constants.mainColor)
                        .background(Color.white)
                }
                Section(header: Text("Edit Icon")) {
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
            .navigationBarTitle("Edit List")
            .navigationBarItems(leading: Button(action: { self.editList.toggle() }) {
                Text("Cancel")
            }, trailing: Button(action: {
                self.todos.editTodoList(title: self.listTitle, image: self.listIcon, index: self.listIndex)
                self.hideKeyboard()
                self.listTitle = ""
                self.listIcon = 0
                self.editList.toggle()
            }) {
                Text("Done").bold()
            })
        }
    }
}

struct EditList_Previews: PreviewProvider {
    static var previews: some View {
        EditList(listIndex: 0, editList: .constant(false), index: .constant(0))
    }
}
