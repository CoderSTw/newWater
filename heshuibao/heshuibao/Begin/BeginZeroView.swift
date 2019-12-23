//
//  BeginZeroView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/22.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class BeginZeroView: UIView {
    
    private var manBtn: GenderButton!
    private var womenBtn: GenderButton!
    
    //
    private var genderNum = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        manBtn = GenderButton(imgName: "boy", titleName: "男生")
        manBtn.addTarget(self, action: #selector(manBtnClick), for: .touchUpInside)
        manBtn.isSelected = true
        addSubview(manBtn)
        manBtn.snp.makeConstraints { (make) in
            make.top.equalTo(100.imgSize())
            make.left.equalTo(30.imgSize())
            make.width.equalTo(144.imgSize())
            make.bottom.equalTo(self)
        }
        
        womenBtn = GenderButton(imgName: "girl", titleName: "女生")
        womenBtn.addTarget(self, action: #selector(womenBtnClick), for: .touchUpInside)
        womenBtn.isSelected = false
        addSubview(womenBtn)
        womenBtn.snp.makeConstraints { (make) in
            make.top.equalTo(100.imgSize())
            make.right.equalTo(-30.imgSize())
            make.width.equalTo(144.imgSize())
            make.bottom.equalTo(self)
        }
    }
    
    @objc func manBtnClick() {
        manBtn.isSelected = true
        womenBtn.isSelected = false
        genderNum = 0
        UserDefaults.standard.set(genderNum, forKey: GENDER_NUM_KEY)
    }
    
    @objc func womenBtnClick() {
        manBtn.isSelected = false
        womenBtn.isSelected = true
        genderNum = 1
        UserDefaults.standard.set(genderNum, forKey: GENDER_NUM_KEY)
    }
}

class GenderButton: UIButton {
    
    private var img: UIImageView!
    private var label: UILabel!
    
    override var isSelected: Bool {
        didSet {
            if (isSelected == true) {
                img.alpha = 1
                label.textColor = COLOR_MAINTEXTCOLOR
            }else {
                img.alpha = 0.5
                label.textColor = COLOR_DETAILTEXTCOLOR
            }
        }
    }
    
    init(imgName: String, titleName: String) {
        super.init(frame: CGRect.zero)
        
        img = UIImageView(image: UIImage(named: imgName))
        addSubview(img)
        img.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(148.imgSize())
        }
        
        label = UILabel(title: titleName, color: COLOR_DETAILTEXTCOLOR, size: 18.imgSize())
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(img.snp_bottom).offset(35.imgSize())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
