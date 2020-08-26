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
    var iconRowIndex: Int
    var iconSectionIndex: Int
    
    @Binding var editList: Bool
    @Binding var index: Int

    @State var listTitle = ""
    @State var listIcon = 0

    @State var selectedIconSectionIndex = 0
    @State var selectedIconRowIndex = 0

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Edit Title")) {
                    TextField(todos.todos[listIndex].title, text: $listTitle)
                        .foregroundColor(.primary)
                        .accentColor(Color(Constants.mainColor))
                }
                Section(header: Text("Select Icon")) {
                    NavigationLink(destination: IconChoice(selectedIconRowIndex: $selectedIconRowIndex, selectedIconSectionIndex: $selectedIconSectionIndex)) {
                        HStack {
                            Text("Please edit your icon")
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
            .navigationBarTitle("Edit List")
            .navigationBarItems(leading: Button(action: { self.editList.toggle() }) {
                Text("Cancel")
            }, trailing: Button(action: {
                if self.listTitle == "" { self.listTitle = self.todos.todos[self.listIndex].title }
                self.todos.editTodoList(title: self.listTitle, imageSection: self.selectedIconSectionIndex, imageRow: self.selectedIconRowIndex, index: self.listIndex)
                self.listTitle = ""
                self.listIcon = 0
                self.editList.toggle()
            }) {
                Text("Done").bold()
            })
        }.onAppear {
            self.listTitle = self.todos.todos[self.listIndex].title
            self.selectedIconRowIndex = self.iconRowIndex
            self.selectedIconSectionIndex = self.iconSectionIndex
        }
    }
}

struct EditList_Previews: PreviewProvider {
    static var previews: some View {
        EditList(listIndex: 0, iconRowIndex: 0, iconSectionIndex: 0, editList: .constant(true), index: .constant(0))
    }
}
