//
//  Extention.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit
import SnapKit

let Width = (UIScreen.main.bounds.size.width > 414) ? (UIScreen.main.bounds.size.width / 1.5) : (UIScreen.main.bounds.size.width)


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SafeAreaBottomHeight: CGFloat = ((UIScreen.main.bounds.size.height == 812.0 || UIScreen.main.bounds.size.height == 896.0) ? 34.0 : 0.0)
let ipadWidth: CGFloat = (UIScreen.main.bounds.size.width > 414) ? 50/1024*SCREEN_WIDTH : 0

let COLOR_MAINTEXTCOLOR = UIColor(named: "MainTextColor")!
let COLOR_DETAILTEXTCOLOR = UIColor(named: "DetailTextColor")!
let COLORT_MAIN_BLUE = UIColor(r: 106, g: 167, b: 248)

// USER KEYS
let GENDER_NUM_KEY = "GENDER_NUM_KEY"
let HEIGHT_ROW_KEY = "HEIGHT_ROW_KEY"
let WEIGHT_ROW_KEY = "WEIGHT_ROW_KEY"
let SPORT_HABBIT_KEY = "SPORT_HABBIT_KEY"
let FIRST_TIME_KEY = "FIRST_TIME_KEY"
let REMINDER_STATUS_KEY = "REMINDER_STATUS_KEY"
let DAEK_MODE_KEY = "DAEK_MODE_KEY"

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}

extension Int {
    func imgSize() -> CGFloat {
        return CGFloat(self) / 414 * Width
    }
}

extension Double {
    func imgSize() -> CGFloat {
        return CGFloat(self) / 414 * Width
    }
}

extension CGFloat {
    func imgSize() -> CGFloat {
        return CGFloat(self) / 414 * Width
    }
}

extension UILabel {
    convenience init(title: String, color: UIColor, size: CGFloat, weight: UIFont.Weight = UIFont.Weight.regular) {
        self.init()
        self.text = title
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
}

extension UIView {
    func cornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension UILabel {
    /**  改变字间距  */
    func changeWordSpace(space:CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!, attributes: [NSAttributedString.Key.kern:space])
        let paragraphStyle = NSMutableParagraphStyle()
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.attributedText = attributedString
        self.sizeToFit()
    }
    
    /**  改变行间距  */
    func changeLineSpace(space:CGFloat) {
        if self.text == nil || self.text == "" {
            return
        }
        let text = self.text
        let attributedString = NSMutableAttributedString.init(string: text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text!.count))
        self.attributedText = attributedString
        self.sizeToFit()
    }
}
