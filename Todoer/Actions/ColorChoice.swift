//
//  ColorChoice.swift
//  Todoer
//
//  Created by Andrew Lawler on 19/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct ColorChoice: View {

    @Binding var selectedColorRowIndex: Int

    func amISelected(row: Int) -> Bool {
        if row == selectedColorRowIndex{ return true }
        else { return false }
    }

    var body: some View {
        List {
            Section(header: Text("Select a color")) {
                ForEach(Constants.colors.indices, id: \.self) { colorIndex in
                    HStack {
                        Color(Constants.colors[colorIndex].color)
                            .frame(width: 20, height: 20)
                            .cornerRadius(5)
                        Text(Constants.colors[colorIndex].name)
                            .foregroundColor(Color.primary)
                            .padding(.leading, 5)
                        Spacer()
                        if self.amISelected(row: colorIndex) {
                            Image(systemName: "checkmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 15, height: 15)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(Color(Constants.mainColor))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity)
                    .background(Color("iconSelectionRow").opacity(0.01))
                    .onTapGesture {
                        self.selectedColorRowIndex = colorIndex
                        Constants.mainColor = Constants.colors[colorIndex].color
                        Constants.mainColorIndex = colorIndex
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .environment(\.horizontalSizeClass, .regular)
        .navigationBarTitle("Choose Color")
    }
}

struct ColorChoice_Previews: PreviewProvider {
    static var previews: some View {
        ColorChoice(selectedColorRowIndex: .constant(0))
    }
}
