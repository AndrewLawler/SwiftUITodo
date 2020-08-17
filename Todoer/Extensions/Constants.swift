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

enum Constants {
    static let mainColor = Color(#colorLiteral(red: 0.07450980392, green: 0.568627451, blue: 0.8784313725, alpha: 1))
    static let icons: [Icon] = [
        Icon(name: "bell.fill"),
        Icon(name: "book.fill"),
        Icon(name: "calendar"),
    ]
}
