//
//  Constants.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

struct Icon: Identifiable {
    let id = UUID()
    let name: String
}

struct ColorChoice: Identifiable {
    let id = UUID()
    let color: Color
}

enum Constants {
    static var mainColor = Color(#colorLiteral(red: 0.07450980392, green: 0.568627451, blue: 0.8784313725, alpha: 1))
    static var mainColorIndex = 0
    static let icons: [Icon] = [
        Icon(name: "bell.fill"),
        Icon(name: "book.fill"),
        Icon(name: "calendar"),
    ]
    static let colors: [ColorChoice] = [
        ColorChoice(color: Color(#colorLiteral(red: 0.07450980392, green: 0.568627451, blue: 0.8784313725, alpha: 1))),
        ColorChoice(color: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))),
        ColorChoice(color: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))),
        ColorChoice(color: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
    ]
}
