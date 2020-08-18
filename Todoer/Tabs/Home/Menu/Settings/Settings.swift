//
//  Settings.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct Settings: View {

    @State var notificationState = false
    @State var colorIndex = Constants.mainColorIndex
    @State var iconIndex = 0

    @Binding var showSettings: Bool

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Customisation")) {
                    Toggle(isOn: $notificationState) {
                        HStack {
                            ZStack {
                                Constants.mainColor
                                    .frame(width: 30, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "bell.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.white)
                            }
                            Text("Notifications")
                                .padding(.leading, 5)
                        }
                    }
                    Picker(selection: $colorIndex, label:
                        HStack {
                            ZStack {
                                Constants.mainColor
                                    .frame(width: 30, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "paintbrush.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.white)
                            }
                            Text("Color")
                                .padding(.leading, 5)
                        }
                    ){
                        ForEach(0 ..< Constants.colors.count) {
                            Constants.colors[$0].color
                                .frame(width: 20, height: 20)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
//                    Picker(selection: $iconIndex, label:
//                        HStack {
//                            ZStack {
//                                Constants.mainColor
//                                    .frame(width: 30, height: 30)
//                                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                                Image(systemName: "pencil")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(Color.white)
//                            }
//                            Text("App Icon")
//                                .padding(.leading, 5)
//                        }
//                    ){
//                        ForEach(0 ..< Constants.icons.count) {
//                            Image(systemName: "\(Constants.icons[$0].name)")
//                                .foregroundColor(Constants.mainColor)
//                        }
//                    }
                }
                Section(header: Text("Developer")) {
                    NavigationLink(destination: Settings(showSettings: self.$showSettings)) {
                        HStack {
                            ZStack {
                                Constants.mainColor
                                    .frame(width: 30, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.white)
                            }
                            Text("Follow Me")
                                .foregroundColor(Color.primary)
                                .padding(.leading, 5)
                        }
                    }
                    NavigationLink(destination: Settings(showSettings: self.$showSettings)) {
                        HStack {
                            ZStack {
                                Constants.mainColor
                                    .frame(width: 30, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.white)
                            }
                            Text("Rate App")
                                .foregroundColor(Color.primary)
                                .padding(.leading, 5)
                        }
                    }
//
//                    Link(destination: URL(string: "https://www.apple.com")!) {
//                        HStack {
//                            ZStack {
//                                Color(#colorLiteral(red: 0.07450980392, green: 0.568627451, blue: 0.8784313725, alpha: 1))
//                                    .frame(width: 30, height: 30)
//                                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                                Image(systemName: "star.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(Color.white)
//                            }
//                            Text("Rate App")
//                                .foregroundColor(.black)
//                                .padding(.leading, 5)
//                        }
//                    }

                }

                Section(header: Text("App Version")) {
                    Text("Version 1.0")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Constants.mainColor)
                        .font(.system(size: 15))
                }
            }
            .navigationBarTitle("Settings")
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarItems(leading: Button(action: { self.showSettings.toggle() }) {
                Text("Cancel")
                }, trailing: Button(action: {
                    self.showSettings.toggle()
                    Constants.mainColor = Constants.colors[self.colorIndex].color
                    Constants.mainColorIndex = self.colorIndex
                }) {
                Text("Done").bold()
            })
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(showSettings: .constant(false))
    }
}
