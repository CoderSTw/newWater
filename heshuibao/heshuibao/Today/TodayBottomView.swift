//
//  TodayBottomView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/22.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class TodayBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // 1. 左边进度条
        
        // 2. 右边的文字
        let targetLabel = setupRightText(centerYOffX: -20.imgSize(), imgName: "targetDot", leftName: "今日目标：", rightName: "2.00 L")
        
        let finishiLabel = setupRightText(centerYOffX: 20.imgSize(), imgName: "finishiDot", leftName: "今日完成：", rightName: "0.50 L")
    }
    
    private func setupRightText(centerYOffX: CGFloat, imgName: String, leftName: String, rightName: String) -> UILabel {
        
        let leftImg = UIImageView(image: UIImage(named: imgName))
        addSubview(leftImg)
        leftImg.snp.makeConstraints { (make) in
            make.left.equalTo(190.imgSize())
            make.centerY.equalTo(self).offset(centerYOffX)
            make.width.height.equalTo(18.imgSize())
        }
        
        let leftLabel = UILabel(title: leftName, color: COLOR_DETAILTEXTCOLOR, size: 18.imgSize())
        addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftImg)
            make.left.equalTo(leftImg.snp_right).offset(10.imgSize())
        }
        
        let rightLabel = UILabel(title: rightName, color: COLOR_MAINTEXTCOLOR, size: 18.imgSize(), weight: .thin)
        addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftImg)
            make.right.equalTo(-35.imgSize())
        }
        
        return rightLabel
    }

}
