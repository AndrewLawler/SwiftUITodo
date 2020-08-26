//
//  EditSubTodo.swift
//  Todoer
//
//  Created by Andrew Lawler on 18/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct EditSubTodo: View {

    @EnvironmentObject var todos: TodoStore

    var todoIndex: Int
    var subTodoIndex: Int

    @State var todoTitle = ""
    @Binding var editSubTodo: Bool
    @Binding var index: Int

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Edit Title")) {
                    TextField(todos.todos[index].todos[todoIndex].subTodos[subTodoIndex].content, text: $todoTitle)
                        .foregroundColor(.primary)
                        .accentColor(Constants.mainColor)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        self.todos.deleteSubTodo(index: self.index, todoIndex: self.todoIndex, subTodoIndex: self.subTodoIndex)
                        self.editSubTodo.toggle()
                    }) {
                        Text("Delete")
                    }
                    Spacer()
                }
            }
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Edit Sub Task")
            .navigationBarItems(leading: Button(action: { self.editSubTodo.toggle() }) {
                Text("Cancel")
            }, trailing: Button(action: {
                if self.todoTitle == "" { self.todoTitle = self.todos.todos[self.index].todos[self.todoIndex].subTodos[self.subTodoIndex].content }
                self.todos.replaceSubTodo(listIndex: self.index, index: self.todoIndex, subTodoIndex: self.subTodoIndex, content: self.todoTitle)
                self.editSubTodo.toggle()
                self.todoTitle = ""
            }) {
                Text("Done").bold()
            })
        }.onAppear {
            self.todoTitle = self.todos.todos[self.index].todos[self.todoIndex].subTodos[self.subTodoIndex].content
        }
    }
}

struct EditSubTodo_Previews: PreviewProvider {
    static var previews: some View {
        EditSubTodo(todoIndex: 0, subTodoIndex: 0, editSubTodo: .constant(false), index: .constant(0))
    }
}
