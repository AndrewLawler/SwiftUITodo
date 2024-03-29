//
//  Settings.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI
import UserNotifications

struct Settings: View {

    @EnvironmentObject var todos: TodoStore

    @State var notificationState = false
    @State var colorIndex = Constants.mainColorIndex
    @State var iconIndex = 0
    @State var iconName = ""

    @Binding var showSettings: Bool

    @State var notificationPermissions = false

    /// dev

    func openDeveloperTwitter() {
        let url = URL (string: "https://twitter.com/andylawler_dev")!
        UIApplication.shared.open (url)
    }

    /// app

    func openAppTwitter() {
        let url = URL (string: "https://www.twitter.com/tasklist_app")!
        UIApplication.shared.open (url)
    }

    func openAppInstagram() {
        let url = URL (string: "https://www.instagram.com/tasklist_app")!
        UIApplication.shared.open (url)
    }

    func openAppWebsite() {
        let url = URL (string: "https://www.andrewlawler.me")!
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
                if self.notificationPermissions {
                    Section(header: Text("Notifications")) {
                        Toggle(isOn: $notificationState) {
                            HStack {
                                ZStack {
                                    Color(Constants.mainColor)
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
                    }
                } else {
                    Section(header: Text("Notifications")) {
                        HStack {
                            Text("Enable notifications from your Settings")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color(Constants.mainColor))
                                .font(.system(size: 15))
                        }.onTapGesture {
                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        }

                    }
                }
                Section(header: Text("Customisation")) {
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
                    NavigationLink(destination: AppIconChoice(iconChoice: $iconName, selectedIconRow: Int(getAppIcon())! - 1)) {
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
                Section(header: Text("Socials")) {
                    HStack {
                        ZStack {
                            Color(Constants.mainColor)
                                .frame(width: 30, height: 30)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "hammer.fill")
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
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(Color("iconSelectionRow").opacity(0.01))
                    .onTapGesture {
                        self.openDeveloperTwitter()
                    }
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
                        Text("Twitter")
                            .foregroundColor(Color.primary)
                            .padding(.leading, 5)
                        Spacer()
                        Image(systemName: "arrow.right.square")
                            .foregroundColor(Color(Constants.mainColor))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(Color("iconSelectionRow").opacity(0.01))
                    .onTapGesture {
                        self.openAppTwitter()
                    }
                    HStack {
                        ZStack {
                            Color(Constants.mainColor)
                                .frame(width: 30, height: 30)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: Constants.images.instagram)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.white)
                        }
                        Text("Instagram")
                            .foregroundColor(Color.primary)
                            .padding(.leading, 5)
                        Spacer()
                        Image(systemName: "arrow.right.square")
                            .foregroundColor(Color(Constants.mainColor))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(Color("iconSelectionRow").opacity(0.01))
                    .onTapGesture {
                        self.openAppInstagram()
                    }
                }
                Section(header: Text("Extras")) {
                    HStack {
                        ZStack {
                            Color(Constants.mainColor)
                                .frame(width: 30, height: 30)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            Image(systemName: "globe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.white)
                        }
                        Text("Website")
                            .foregroundColor(Color.primary)
                            .padding(.leading, 5)
                        Spacer()
                        Image(systemName: "arrow.right.square")
                            .foregroundColor(Color(Constants.mainColor))
                    }.onTapGesture {
                        self.openAppWebsite()
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
                        .foregroundColor(Color.primary)
                        .font(.system(size: 15))
                }
            }
            .navigationBarTitle("Settings")
            .listStyle(GroupedListStyle())
            .environment(\.horizontalSizeClass, .regular)
            .navigationBarItems(trailing: Button(action: {
                    if !self.notificationState {
                        /// delete requests
                        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        /// change all notificationStates to false
                        self.todos.editTodoListTodosNotificationStates()
                    }
                    let num = self.notificationState ? 1 : 0
                    UserDefaults.standard.set(num, forKey: "notifications")
                    UserDefaults.standard.set(self.colorIndex, forKey: "colorIndex")
                    self.showSettings.toggle()
                }) {
                Text("Done").bold()
            })
            .onAppear {
                let id = UserDefaults.standard.integer(forKey: "notifications")
                if id == 1 { self.notificationState = true }
                let id2 = UserDefaults.standard.integer(forKey: "setNotifications")
                if id2 == 1 { self.notificationPermissions = true }
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(showSettings: .constant(false))
    }
}
