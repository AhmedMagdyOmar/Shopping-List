//
//  UIColor.swift
//  Gallery-iOS
//
//  Created by Vlada Radchenko on 10/1/19.
//  Copyright © 2019 Hyper Interaktiv AS. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {

    static var backgroundColor: UIColor {
        if #available(iOS 13, *) {
            return self.backgroundColor
        } else {
            return white
        }
    }

    static var labelColor: UIColor {
        if #available(iOS 13, *) {
            return self.labelColor
        } else {
            return black
        }
    }

    static var blueColor: UIColor {
        if #available(iOS 13, *) {
            return self.blueColor
        } else {
            return UIColor(red: 40/255, green: 170/255, blue: 236/255, alpha: 1)
        }
    }
}
