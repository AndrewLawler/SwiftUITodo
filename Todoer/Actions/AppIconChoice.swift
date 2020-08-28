//
//  AppIconChoice.swift
//  TaskList
//
//  Created by Andrew Lawler on 28/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct AppIconChoice: View {

    @Binding var iconChoice: String

    @State var selectedIconRow: Int?

    func convertRow(row: Int) -> Bool {
        let iconName = UIApplication.shared.alternateIconName ?? "Primary"
        if row == 0 && iconName == "Primary" { return true }
        else if row == 1 && iconName == "AppIconTwo" { return true }
        else { return false }
    }

    func amISelected(row: Int) -> Bool {
        if row == selectedIconRow || convertRow(row: row) { return true }
        else { return false }
    }

    var body: some View {
        List {
            Section(header: Text("App Icons")) {
                ForEach(Constants.appIcons.indices, id: \.self) { iconIndex in
                    HStack {
                        Image(Constants.appIcons[iconIndex].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text(Constants.appIcons[iconIndex].name)
                            .foregroundColor(Color.primary)
                            .padding(.leading, 5)
                        Spacer()
                        if self.amISelected(row: iconIndex) {
                            Image(systemName: Constants.images.check)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(Color(Constants.color.iconRow).opacity(0.01))
                    .onTapGesture {
                        self.selectedIconRow = iconIndex
                        self.iconChoice = "\(iconIndex + 1)"
                        if iconIndex == 0 {
                            UIApplication.shared.setAlternateIconName(nil)
                        } else {
                            UIApplication.shared.setAlternateIconName("AppIconTwo")
                        }
                    }
                }
            }
        }.onAppear {
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("Choose App Icon")
    }
}

struct AppIconChoice_Previews: PreviewProvider {
    static var previews: some View {
        AppIconChoice(iconChoice: .constant(""))
    }
}
