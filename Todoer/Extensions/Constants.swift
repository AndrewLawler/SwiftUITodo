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

struct SectionIcon: Identifiable {
    let id = UUID()
    let title: String
    let icons: [Icon]
}

struct ColorChoice: Identifiable {
    let id = UUID()
    let color: Color
}

enum Constants {

    static var mainColor = Color(#colorLiteral(red: 0.07450980392, green: 0.568627451, blue: 0.8784313725, alpha: 1))
    static var mainColorIndex = 0

    static let icons: [Icon] = [
        Icon(name: "lock.fill"),
        Icon(name: "airplane"),
        Icon(name: "house.fill"),
        Icon(name: "bandage.fill"),
        Icon(name: "cart.fill"),
        Icon(name: "envelope.fill"),
        Icon(name: "scissors"),
        Icon(name: "calendar"),
        Icon(name: "folder.fill"),
        Icon(name: "paperclip"),
        Icon(name: "person.fill"),
        Icon(name: "doc.circle.fill"),
        Icon(name: "sun.min.fill"),
        Icon(name: "globe"),
        Icon(name: "moon.fill"),
        Icon(name: "paperplane.fill"),
        Icon(name: "tray.fill"),
        Icon(name: "cloud.rain.fill"),
        Icon(name: "heart.fill"),
        Icon(name: "flag.fill"),
        Icon(name: "bolt.fill"),
        Icon(name: "message.fill"),
        Icon(name: "phone.fill"),
        Icon(name: "video.fill"),
        Icon(name: "camera.fill"),
        Icon(name: "trash.fill"),
    ]

    static let iconsOrdered: [SectionIcon] = [
        SectionIcon(title: "Popular", icons: [
            Icon(name: "house.fill"),
            Icon(name: "message.fill"),
            Icon(name: "cart.fill"),
            Icon(name: "folder.fill"),
            Icon(name: "phone.fill"),
            Icon(name: "calendar"),
        ]),

        SectionIcon(title: "Health", icons: [
            Icon(name: "heart.fill"),

        ]),
        SectionIcon(title: "World", icons: [
            Icon(name: "sun.min.fill"),
            Icon(name: "bolt.fill"),
            Icon(name: "cloud.rain.fill"),
            Icon(name: "globe"),
            Icon(name: "moon.fill"),
        ]),
        SectionIcon(title: "Accessories", icons: [
            Icon(name: "envelope.fill"),
            Icon(name: "scissors"),
            Icon(name: "paperclip"),
            Icon(name: "lock.fill"),
            Icon(name: "bandage.fill"),
        ]),
        SectionIcon(title: "Random", icons: [
            Icon(name: "airplane"),
            Icon(name: "person.fill"),
            Icon(name: "doc.circle.fill"),
            Icon(name: "paperplane.fill"),
            Icon(name: "tray.fill"),
            Icon(name: "flag.fill"),
            Icon(name: "video.fill"),
            Icon(name: "camera.fill"),
            Icon(name: "trash.fill"),
        ])
    ]

    static let appIcons: [String] = []

    static let colors: [ColorChoice] = [
        ColorChoice(color: Color(#colorLiteral(red: 0.07450980392, green: 0.568627451, blue: 0.8784313725, alpha: 1))),
        ColorChoice(color: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1))),
        ColorChoice(color: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))),
        ColorChoice(color: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
    ]

}
