//
//  IconChoice.swift
//  Todoer
//
//  Created by Andrew Lawler on 18/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct IconChoice: View {

    @Binding var selectedIconRowIndex: Int
    @Binding var selectedIconSectionIndex: Int

    @State var selectedIconRow: Int?
    @State var selectedIconSection: Int?

    func amISelected(row: Int, sec: Int) -> Bool {
        if row == selectedIconRowIndex && sec == selectedIconSectionIndex { return true }
        else { return false }
    }

    var body: some View {
        List {
            ForEach(Constants.iconsOrdered.indices, id: \.self) { sectionIndex in
                Section(header: Text(Constants.iconsOrdered[sectionIndex].title)) {
                    ForEach(Constants.iconsOrdered[sectionIndex].icons.indices, id: \.self) { iconIndex in
                        HStack {
                            Image(systemName: "\(Constants.iconsOrdered[sectionIndex].icons[iconIndex].systemName)")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color(Constants.mainColor))
                            Text(Constants.iconsOrdered[sectionIndex].icons[iconIndex].name)
                                .foregroundColor(Color.primary)
                                .padding(.leading, 5)
                            Spacer()
                            if self.amISelected(row: iconIndex, sec: sectionIndex) {
                                Image(systemName: Constants.images.check)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(Color(Constants.mainColor))
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: .infinity)
                        .background(Color(Constants.color.iconRow).opacity(0.01))
                        .onTapGesture {
                            self.selectedIconRowIndex = iconIndex
                            self.selectedIconSectionIndex = sectionIndex
                            self.selectedIconRow = iconIndex
                            self.selectedIconSection = sectionIndex
                        }
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("Choose Icon")
    }
}

struct IconChoice_Previews: PreviewProvider {
    static var previews: some View {
        IconChoice(selectedIconRowIndex: .constant(0), selectedIconSectionIndex: .constant(0))
    }
}
