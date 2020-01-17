//
//  Extention.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit
import SnapKit

let Width = (UIScreen.main.bounds.size.width > 414) ? (UIScreen.main.bounds.size.width / 1.5) : (UIScreen.main.bounds.size.width)


let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let NEW_AREA: CGFloat = ((UIScreen.main.bounds.size.height == 812.0 || UIScreen.main.bounds.size.height == 896.0) ? 34.0 : 0.0)
let ipadWidth: CGFloat = (UIScreen.main.bounds.size.width > 414) ? 50/1024*SCREEN_WIDTH : 0

let MY_APP_ID = "1493878693"
let HENGFU_ID = "ca-app-pub-1095107296244687/1431266825"
let FULL_ID = "ca-app-pub-1095107296244687/6492021812"

// COLORS
let COLOR_MAINTEXTCOLOR = UIColor(named: "MainTextColor")!
let COLOR_DETAILTEXTCOLOR = UIColor(named: "DetailTextColor")!
let COLOR_BGCOLOR = UIColor(named: "bgcolor")!
let COLORT_MAIN_BLUE = UIColor(named: "mainblue")!

let COLORT_WATER = UIColor(r: 100, g: 181, b: 246)
let COLORT_COFFEE = UIColor(r: 161, g: 136, b: 127)
let COLORT_MILK = UIColor(r: 206, g: 235, b: 253)
let COLORT_TEA = UIColor(r: 197, g: 225, b: 165)
let COLORT_COLA = UIColor(r: 235, g: 126, b: 101)

// USER KEYS
let GENDER_NUM_KEY = "GENDER_NUM_KEY"
let HEIGHT_ROW_KEY = "HEIGHT_ROW_KEY"
let WEIGHT_ROW_KEY = "WEIGHT_ROW_KEY"
let SPORT_HABBIT_KEY = "SPORT_HABBIT_KEY"
let FIRST_TIME_KEY = "FIRST_TIME_KEY"
let REMINDER_STATUS_KEY = "REMINDER_STATUS_KEY"
let DAEK_MODE_KEY = "DAEK_MODE_KEY"
let TIME_SEL_ROW_KEY = "TIME_SEL_ROW_KEY"
let RING_SEL_ROW_KEY = "RING_SEL_ROW_KEY"
let NOTE_ARR_KEY = "NOTE_ARR_KEY"
let NOTE_SEL_ROW_KEY = "NOTE_SEL_ROW_KEY"
let NEAL_NAME_KEY = "NEAL_NAME_KEY"
let IS_AUTO_KEY = "IS_AUTO_KEY"

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}

extension Int {
    func IMGPX() -> CGFloat {
        return CGFloat(self) / 414 * Width
    }
    
    func getVersionStr() -> String {
        return "v \(Bundle.main.infoDictionary!["CFBundleShortVersionString"] ?? 1)"
    }
}

extension Double {
    func IMGPX() -> CGFloat {
        return CGFloat(self) / 414 * Width
    }
}

extension CGFloat {
    func IMGPX() -> CGFloat {
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

extension UIView {
    //将当前视图转为UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
