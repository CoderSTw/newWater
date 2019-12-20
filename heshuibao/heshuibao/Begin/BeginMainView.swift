//
//  BeginMainView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class BeginMainView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        //
        let titleLabel = UILabel(title: "请选择您的性别", color: COLOR_MAINTEXTCOLOR, size: 30.imgSize(), weight: .medium)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.top.equalTo(self)
        }
        
        //
        let detailLabel = UILabel(title: "请正确填写您的信息以便与软件推算出您每日推荐的饮水量。", color: COLOR_DETAILTEXTCOLOR, size: 18.imgSize())
        detailLabel.numberOfLines = 0
        detailLabel.changeLineSpace(space: 10.imgSize())
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(15.imgSize())
            make.right.equalTo(-30.imgSize())
        }
        
        //
        
    }

}
