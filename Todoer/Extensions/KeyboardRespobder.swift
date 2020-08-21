//
//  KeyboardRespobder.swift
//  Todoer
//
//  Created by Andrew Lawler on 15/08/2020.
//  Copyright © 2020 andyLawler. All rights reserved.
//

import Foundation
import SwiftUI

/// keyboard responder used to shift the view upwards
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

/// hide keyboard function used if the screen is tapped

#if canImport(UIKit)
extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
#endif
