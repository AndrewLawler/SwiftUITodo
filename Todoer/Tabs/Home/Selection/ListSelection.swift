//
//  ListSelection.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct ListSelection: View {
    
    @EnvironmentObject var todos: TodoStore

    @State var addList = false
    @State var listTitle = ""
    @State var editList = false

    @Binding var index: Int
    @Binding var showLists: Bool
    @Binding var addedList: Bool
    @Binding var showList: Bool

    var body: some View {
        VStack {
            HStack {
                Text("Lists").font(.largeTitle).bold()
                Spacer()
                Button(action: { self.addList.toggle() }) {
                    ImageMenuButton(image: "book.fill")
                }
                .padding(.trailing, 10)
                .sheet(isPresented: $addList) {
                    AddList(addList: self.$addList, index: self.$index, addedList: self.$addedList, showList: self.$showList)
                }.padding(.trailing, 10)
            }
            .padding(.top, 40)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            List {
                ForEach(self.todos.todos.indices, id: \.self) { todoIndex in
                    HStack {
                        ZStack {
                            Color(#colorLiteral(red: 0.07450980392, green: 0.568627451, blue: 0.8784313725, alpha: 1))
                                .frame(width: 80, height: 80)
                                .cornerRadius(20)
                            Image(systemName: Constants.icons[self.todos.todos[todoIndex].image].name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.white)
                        }.onTapGesture {
                            self.index = todoIndex
                            self.showLists.toggle()
                        }
                        Text(self.todos.todos[todoIndex].title)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.leading, 10)
                        Spacer()
                        Button(action: {
                            self.editList.toggle()
                        }) {
                            ZStack {
                                Color(#colorLiteral(red: 0.07450980392, green: 0.568627451, blue: 0.8784313725, alpha: 1))
                                    .frame(width: 25, height: 25)
                                    .clipShape(Circle())
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            }
                        }.padding(.trailing, 10)
                        .frame(width: 25, height: 25)
                        .sheet(isPresented: self.$editList) {
                            EditList(listIndex: todoIndex, editList: self.$editList, index: self.$index, showList: self.$showList)
                                .environmentObject(self.todos)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
        }
    }
}

struct ListSelection_Previews: PreviewProvider {
    static var previews: some View {
        ListSelection(index: .constant(0), showLists: .constant(false), addedList: .constant(false), showList: .constant(false))
    }
}
