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

    var body: some View {
        VStack {
            HStack {
                Text("Lists").font(.largeTitle).bold()
                Spacer()
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
                }.padding(.trailing, 10)
                ZStack {
                    CircleBackground()
                    EditButton()
                        .font(.system(size: 15))
                        .foregroundColor(Constants.mainColor)
                }
            }
            .padding(.top, 40)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            
            List {
                ForEach(self.todos.todos.indices, id: \.self) { todoIndex in
                    HStack {
                        ZStack {
                            Constants.mainColor
                                .frame(width: 80, height: 80)
                                .cornerRadius(20)
                            Image(systemName: Constants.icons[self.todos.todos[todoIndex].image].name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .foregroundColor(Color.white)
                        }.frame(width: 80, height: 80)
                        .onTapGesture {
                            self.index = todoIndex
                            self.showLists.toggle()
                        }
                        Text(self.todos.todos[todoIndex].title)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.leading, 10)
                            .frame(width: 230, height: 80, alignment: .leading)
                        Spacer()
                        Button(action: {
                            self.editList.toggle()
                        }) {
                            ZStack {
                                Constants.mainColor
                                    .frame(width: 25, height: 25)
                                    .clipShape(Circle())
                                Image(systemName: "ellipsis")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            }.frame(width: 25, height: 25)
                        }
                        .sheet(isPresented: self.$editList) {
                            EditList(listIndex: todoIndex, editList: self.$editList, index: self.$index)
                                .environmentObject(self.todos)
                        }
                    }
                    .padding(.vertical, 8)
                }.onDelete { index in
                    self.todos.todos.remove(at: index.first!)
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.todos.todos.move(fromOffsets: source, toOffset: destination)
                }
            }
        }
    }
}

struct ListSelection_Previews: PreviewProvider {
    static var previews: some View {
        ListSelection(index: .constant(0), showLists: .constant(false), addedList: .constant(false))
    }
}
