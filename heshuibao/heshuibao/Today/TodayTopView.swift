//
//  TodayTopView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

protocol TodayTopViewDelegate: NSObject {
    func TodayTopViewDidClickDrinkBtn()
}

class TodayTopView: UIView {
    
    //
    weak var delegate: TodayTopViewDelegate?
    private var mlLabel: UILabel!

    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        //
        let bgImgView = UIImageView(image: UIImage(named: "mainbg"))
        bgImgView.isUserInteractionEnabled = true
        addSubview(bgImgView)
        bgImgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        //
        let todayLabel = UILabel(title: "今天", color: .white, size: 30.imgSize(), weight: .medium)
        bgImgView.addSubview(todayLabel)
        todayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.top.equalTo(65.imgSize())
        }
        
        //
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "MM / dd"
        let dateStr = dateFmt.string(from: Date())
        
        let dateLabel = UILabel(title: dateStr, color: UIColor(r: 209, g: 227, b: 252), size: 18.imgSize())
        bgImgView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(todayLabel).offset(3.imgSize())
            make.top.equalTo(todayLabel.snp.bottom).offset(10.imgSize())
        }
        
        //
        mlLabel = UILabel(title: "\(TodayViewModel.getTodayCount()) ML", color: .white, size: 30.imgSize(), weight: .medium)
        bgImgView.addSubview(mlLabel)
        mlLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(145.imgSize())
        }
        
        //
        let pingziImg = UIImageView(image: UIImage(named: "pingzi"))
        bgImgView.addSubview(pingziImg)
        pingziImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(mlLabel.snp.bottom).offset(25.imgSize())
            make.width.equalTo(223.imgSize())
            make.height.equalTo(313.imgSize())
        }
        
        //
        let drinkBtn = UIButton(type: .custom)
        drinkBtn.setBackgroundImage(UIImage(named: "drinkBtn"), for: .normal)
        drinkBtn.addTarget(self, action: #selector(drinkBtnClick), for: .touchUpInside)
        bgImgView.addSubview(drinkBtn)
        drinkBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(-25.imgSize())
            make.width.equalTo(264.imgSize())
            make.height.equalTo(82.imgSize())
        }
        
        let drinkLabel = UILabel(title: "喝水", color: UIColor(r: 52, g: 71, b: 95), size: 25.imgSize(), weight: .medium)
        drinkBtn.addSubview(drinkLabel)
        drinkLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(drinkBtn)
            make.centerY.equalTo(drinkBtn).offset(-3.imgSize())
        }
        
    }
    
}

extension TodayTopView {
    
    @objc func drinkBtnClick() {
        delegate?.TodayTopViewDidClickDrinkBtn()
    }
    
    func updateData() {
        mlLabel.text = "\(TodayViewModel.getTodayCount()) ML"
    }
}
