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
    let systemName: String
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

    static let iconsOrdered: [SectionIcon] = [
        SectionIcon(title: "Popular", icons: [
            Icon(systemName: "house.fill", name: "House"),
            Icon(systemName: "message.fill", name: "Message"),
            Icon(systemName: "cart.fill", name: "Cart"),
            Icon(systemName: "folder.fill", name: "Folder"),
            Icon(systemName: "phone.fill", name: "Phone"),
            Icon(systemName: "calendar", name: "Calendar"),
        ]),

        SectionIcon(title: "Health", icons: [
            Icon(systemName: "heart.fill", name: "Heart"),

        ]),
        SectionIcon(title: "World", icons: [
            Icon(systemName: "sun.min.fill", name: "Sun"),
            Icon(systemName: "bolt.fill", name: "Lightning"),
            Icon(systemName: "cloud.rain.fill", name: "Cloud"),
            Icon(systemName: "globe", name: "Globe"),
            Icon(systemName: "moon.fill", name: "Moon"),
        ]),
        SectionIcon(title: "Accessories", icons: [
            Icon(systemName: "envelope.fill", name: "Envelope"),
            Icon(systemName: "scissors", name: "Scissors"),
            Icon(systemName: "paperclip", name: "Paperclip"),
            Icon(systemName: "lock.fill", name: "Lock"),
            Icon(systemName: "bandage.fill", name: "Bandage"),
        ]),
        SectionIcon(title: "Random", icons: [
            Icon(systemName: "airplane", name: "Airplane"),
            Icon(systemName: "person.fill", name: "Person"),
            Icon(systemName: "doc.circle.fill", name: "Document"),
            Icon(systemName: "paperplane.fill", name: "Paperplane"),
            Icon(systemName: "tray.fill", name: "Tray"),
            Icon(systemName: "flag.fill", name: "Flag"),
            Icon(systemName: "video.fill", name: "Video"),
            Icon(systemName: "camera.fill", name: "Camera"),
            Icon(systemName: "trash.fill", name: "Trash"),
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
