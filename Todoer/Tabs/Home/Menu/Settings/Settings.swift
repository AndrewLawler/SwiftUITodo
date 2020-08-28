//
//  Settings.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct Settings: View {

    @EnvironmentObject var todos: TodoStore

    @State var notificationState = false
    @State var colorIndex = Constants.mainColorIndex
    @State var iconIndex = 0
    @State var iconName = ""

    @Binding var showSettings: Bool

    func openDeveloper() {
        let url = URL (string: "http://twitter.com/andylawler_dev")!
        UIApplication.shared.open (url)
    }

    func openRate() {

    }

    func getAppIcon() -> String {
        if iconName == "" {
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
        } else {
            return iconName
        }
        return "1"
    }

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Customization")) {
//                    Toggle(isOn: $notificationState) {
//                        HStack {
//                            ZStack {
//                                Constants.mainColor
//                                    .frame(width: 30, height: 30)
//                                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                                Image(systemName: "bell.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 20, height: 20)
//                                    .foregroundColor(Color.white)
//                            }
//                            Text("Notifications")
//                                .padding(.leading, 5)
//                        }
//                    }
                    NavigationLink(destination: ColorChoice(selectedColorRowIndex: self.$colorIndex)) {
                        HStack {
                            ZStack {
                                Color(Constants.mainColor)
                                    .frame(width: 30, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "paintbrush.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.white)
                            }
                            Text("Color")
                                .foregroundColor(Color.primary)
                                .padding(.leading, 5)
                            Spacer()
                            Color(Constants.colors[self.colorIndex].color)
                                .frame(width: 20, height: 20)
                                .cornerRadius(5)
                        }
                    }
                    NavigationLink(destination: AppIconChoice(iconChoice: $iconName)) {
                        HStack {
                            ZStack {
                                Color(Constants.mainColor)
                                    .frame(width: 30, height: 30)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                Image(systemName: "pencil.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.white)
                            }
                            Text("App Icon")
                                .foregroundColor(Color.primary)
                                .padding(.leading, 5)
                            Spacer()
                            Image(getAppIcon())
                            .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .cornerRadius(5)
                        }
                    }
                }
                Section(header: Text("App")) {
                    HStack {
                        ZStack {
                            Color(Constants.mainColor)
                                .frame(width: 30, height: 30)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "person.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.white)
                        }
                        Text("Developer")
                            .foregroundColor(Color.primary)
                            .padding(.leading, 5)
                        Spacer()
                        Image(systemName: "arrow.right.square")
                            .foregroundColor(Color(Constants.mainColor))
                    }.onTapGesture {
                        self.openDeveloper()
                    }
//                    HStack {
//                        ZStack {
//                            Color(Constants.mainColor)
//                                .frame(width: 30, height: 30)
//                                .clipShape(RoundedRectangle(cornerRadius: 5))
//                            Image(systemName: "star.fill")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 20, height: 20)
//                                .foregroundColor(Color.white)
//                        }
//                        Text("Rate App")
//                            .foregroundColor(Color.primary)
//                            .padding(.leading, 5)
//                        Spacer()
//                        Image(systemName: "arrow.right.square")
//                            .foregroundColor(Color(Constants.mainColor))
//                    }.onTapGesture {
//                        self.openRate()
//                    }
                }
                Section(header: Text("Release")) {
                    Text("Version \(Constants.version)")
                        .frame(maxWidth: .infinity)
                        .foregroundColor(Color(Constants.mainColor))
                        .font(.system(size: 15))
                }
            }
            .navigationBarTitle("Settings")
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarItems(leading: Button(action: { self.showSettings.toggle() }) {
                Text("Cancel")
                }, trailing: Button(action: {
                    self.todos.changeColorPreference(colorIndex: self.colorIndex)
                    self.showSettings.toggle()
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
