//
//  Constants.swift
//  Todoer
//
//  Created by Andrew Lawler on 16/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import SwiftUI

/// icon structure which contains system name and name
struct Icon: Identifiable {
    let id = UUID()
    let systemName: String
    let name: String
}

/// section icon which contains array of icons and then title for the section
struct SectionIcon: Identifiable {
    let id = UUID()
    let title: String
    let icons: [Icon]
}

/// color option which contains a name and color
struct ColorOption: Identifiable {
    let id = UUID()
    let color: Color
    let name: String
}

/// enum used to reference static variables across the app
enum Constants {

    static var version = "1.0"

    static var mainColor = Color(#colorLiteral(red: 0.07450980392, green: 0.568627451, blue: 0.8784313725, alpha: 1))
    static var mainColorIndex = 0

    enum color {
        static let darkMenuCircle = "darkModeMenuCircle"
        static let appBG = "appBackground"
        static let todo = "todoIcon"
        static let todoBG = "todoIconBackground"
        static let emptyTitle = "emptyStateTitle"
        static let menuTab = "menuTabBar"
        static let iconRow = "iconSelectionRow"
    }

    enum welcome {
        static let title = "Welcome to Todoer"
    }

    enum images {
        static let check = "checkmark"
        static let checkmark = "checkmark.circle"
        static let ellipsis = "ellipsis"
        static let plus = "plus"
        static let plusCircle = "plus.circle"
        static let menuArrow = "arrowshape.turn.up.left.fill"
        static let edit = "pencil"
        static let list = "doc.text.fill"
        static let settings = "gear"
        static let bulletList = "list.bullet"
    }

    enum emptyState {
        static let title = "Oops, I'm Empty!"
        static let listSubTitle = "Add a todo list using the\nbutton below."
        static let todoSubtitle = "Add a todo using the\nbutton below."
    }

    enum listSelect {
        static let title = "Lists"
        static let todo = "todo"
        static let todos = "todos"
        static let subtodo = "sub todo"
        static let subtodos = "sub todos"
    }

    /// ordered icons into sections, used in Icon Choice View
    static let iconsOrdered: [SectionIcon] = [
        SectionIcon(title: "Popular", icons: [
            Icon(systemName: "house.fill", name: "House"),
            Icon(systemName: "message.fill", name: "Message"),
            Icon(systemName: "cart.fill", name: "Cart"),
            Icon(systemName: "folder.fill", name: "Folder"),
            Icon(systemName: "phone.fill", name: "Phone"),
            Icon(systemName: "calendar", name: "Calendar"),
            Icon(systemName: "car.fill", name: "Car")
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
            Icon(systemName: "clock.fill", name: "Clock"),
        ])
    ]

    /// custom app icons when we get up and running with the app icon
    static let appIcons: [String] = []

    /// color choices for the user to pick from
    static let colors: [ColorOption] = [
        ColorOption(color: Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), name: "Blue"),
        ColorOption(color: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), name: "Pink"),
        ColorOption(color: Color(#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)), name: "Orange"),
        ColorOption(color: Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)), name: "Green"),
        ColorOption(color: Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), name: "Yellow"),
        ColorOption(color: Color(#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)), name: "Purple"),
    ]

}

enum ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom = UIDevice.current.userInterfaceIdiom
    static let nativeScale = UIScreen.main.nativeScale
    static let scale = UIScreen.main.scale

    static let isiPhoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale < scale
    static let isiPhoneX = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
