//
//  UIView+Shadow.swift
//  HomeCook
//
//  Created by Onur Cevik on 26.02.2021.
//

import UIKit

enum DropShadowStyle {
    case Card, Button, Apple, NavBar, Readable

    var shadowOffset: CGSize {
        switch self {
        case .Card:
            return .init(width: 1.0, height: 10.0)
        case .Button:
            return .init(width: 1.0, height: 2.0)
        case .Apple:
            return .init(width: 1.0, height: 4.0)
        case .NavBar:
            return .init(width: 0.0, height: 2.0)
        case .Readable:
            return .init(width: 1.0, height: 1.0)
        }
    }

    var shadowRadius: CGFloat {
        switch self {
        case .Card:
            return 10.0
        case .Button:
            return 6.0
        case .Apple:
            return 8.0
        case .NavBar:
            return 4.0
        case .Readable:
            return 2.0
        }
    }

    var shadowOpacityWhenDark: Float {
        switch self {
        case .Card:
            return 1
        case .Button:
            return 0.2
        case .Apple:
            return 0.4
        case .NavBar:
            return 0.1
        case .Readable:
            return 0.25
        }
    }
}

extension UIView {
    func setDropShadow<T: UIView>(to views: [T], withStyles styles: [DropShadowStyle]) {
        guard views.count == styles.count else { return }
        for (index, view) in views.enumerated() {
            let style = styles[index]
            view.layer.shadowColor = UIColor(red: 112/255, green: 144/255, blue: 176/255, alpha: 0.2).cgColor
            if traitCollection.userInterfaceStyle == .dark {
                view.layer.shadowOpacity = style.shadowOpacityWhenDark
            } else {
                view.layer.shadowOpacity = 1
            }
            view.layer.shadowOffset = style.shadowOffset
            view.layer.shadowRadius = style.shadowRadius
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor(red: 156/255, green: 185/255, blue: 214/255, alpha: 0.1).cgColor
        }
    }
}
