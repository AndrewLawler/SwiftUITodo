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
                                .foregroundColor(Color.primary)
                                .padding(.leading, 5)
                            Spacer()
                            Constants.colors[self.colorIndex].color
                                .frame(width: 20, height: 20)
                                .cornerRadius(5)
                        }
                    }
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
                }

                Section(header: Text("App Version")) {
                    Text("Version \(Constants.version)")
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
