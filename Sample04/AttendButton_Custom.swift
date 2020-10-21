//
//  File.swift
//  Sample04
//
//  Created by CRK on 2020/10/21.
//

import Foundation
import UIKit
 
@IBDesignable
class AttendButton_Custom: UIButton {

@IBInspectable var textColor: UIColor?

@IBInspectable var cornerRadius: CGFloat = 0 {
   didSet {
       layer.cornerRadius = cornerRadius
   }
}

@IBInspectable var borderWidth: CGFloat = 0 {
   didSet {
       layer.borderWidth = borderWidth
   }
}
}
