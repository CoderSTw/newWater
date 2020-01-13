//
//  SetTopView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class SetTopView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        //
        backgroundColor = COLORT_MAIN_BLUE
        
        //
        let bgShadowView = UIImageView(image: UIImage(named: "setshadow"))
        addSubview(bgShadowView)
        bgShadowView.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.top.equalTo(100.imgSize())
            make.width.equalTo(120.imgSize())
            make.height.equalTo(119.imgSize())
        }
        
        //
        let iconImg = UIImageView(image: UIImage(named: "icon"))
        iconImg.contentMode = .scaleAspectFit
        iconImg.cornerRadius(radius: 18.imgSize())
        addSubview(iconImg)
        iconImg.snp.makeConstraints { (make) in
            make.centerX.top.equalTo(bgShadowView)
            make.width.height.equalTo(114.imgSize())
        }
        
        //
        let nameLabel = UILabel(title: "石头哥哥会放屁", color: .white, size: 18.imgSize(), weight: .medium)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bgShadowView.snp_right).offset(60.imgSize())
            make.top.equalTo(bgShadowView).offset(10.imgSize())
        }
        
        //
        let mlLabel = UILabel()
        mlLabel.text = "2000"
        mlLabel.textColor = .white
        mlLabel.font = UIFont(name: "Avenir-MediumOblique", size: 60.imgSize())
        mlLabel.textAlignment = .center
        addSubview(mlLabel)
        mlLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottom)
            make.width.equalTo(200.imgSize())
        }
        
        //
        let detailLabel = UILabel(title: "ML", color: .white, size: 15.imgSize(), weight: .medium)
        detailLabel.alpha = 0.7
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-40.imgSize())
            make.bottom.equalTo(-5.imgSize())
        }
    }

}
