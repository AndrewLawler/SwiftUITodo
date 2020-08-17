//
//  KeyboardRespobder.swift
//  Todoer
//
//  Created by Andrew Lawler on 15/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import Foundation
import SwiftUI

class KeyboardResponder: ObservableObject {

    @Published var currentHeight: CGFloat = 0

    var _center: NotificationCenter

    init(center: NotificationCenter = .default) {
        _center = center
        _center.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        _center.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                withAnimation {
                   currentHeight = keyboardSize.height
                }
            }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        withAnimation {
            currentHeight = 0
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
