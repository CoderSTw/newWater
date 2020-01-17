//
//  BeginFourthView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/22.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class BeginFourthView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private let titleNames = ["身高：", "体重：", "习惯："]
    private let sportNames = ["经常锻炼", "偶尔锻炼", "不常锻炼", "暂时保密"]
    
    //
    private func setup() {
        
        
    }
    
    func reloadData() {
        
        let height = 150 + UserDefaults.standard.integer(forKey: HEIGHT_ROW_KEY)
        let weight = 30 + UserDefaults.standard.integer(forKey: WEIGHT_ROW_KEY)
        
        let detailNames = ["\(height) CM", "\(weight) KG", "\(sportNames[UserDefaults.standard.integer(forKey: SPORT_HABBIT_KEY)])"]
        
        for i in 0..<3 {
            let titleLabel = UILabel(title: titleNames[i], color: COLOR_DETAILTEXTCOLOR, size: 13.IMGPX())
            addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(30.IMGPX())
                make.top.equalTo(self).offset(CGFloat(i)*35.IMGPX())
            }
            
            let detailLabel = UILabel(title: detailNames[i], color: COLOR_MAINTEXTCOLOR, size: 13.IMGPX())
            addSubview(detailLabel)
            detailLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(titleLabel)
                make.left.equalTo(titleLabel.snp_right).offset(15.IMGPX())
            }
        }
        
        // 170 60 == 2000
        //
        let mlValue = (170 - height) * -5 + (60 - weight) * -10 + 2000
//        TodayViewModel.setTargetCount(value: mlValue)
        TodayViewModel.setTuijianTargetCount(value: mlValue)
        
        //
        let mlLabel = UILabel(title: "\(mlValue) ML", color: UIColor(r: 85, g: 151, b: 248), size: 35.IMGPX(), weight: .medium)
        addSubview(mlLabel)
        mlLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30.IMGPX())
            make.top.equalTo(150.IMGPX())
        }
        
        let infoLabel = UILabel(title: "之后在软件设置中可以根据您的需求自定义每日饮水目标。", color: COLOR_DETAILTEXTCOLOR, size: 13.IMGPX())
        infoLabel.alpha = 0.5
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.left.equalTo(mlLabel)
            make.top.equalTo(mlLabel.snp_bottom).offset(20.IMGPX())
        }
    }

}
