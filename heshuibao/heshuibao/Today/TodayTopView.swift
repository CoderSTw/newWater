//
//  TodayTopView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/20.
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
        let todayLabel = UILabel(title: "今天", color: .white, size: 30.IMGPX(), weight: .medium)
        bgImgView.addSubview(todayLabel)
        todayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30.IMGPX())
            make.top.equalTo(31.IMGPX() + NEW_AREA)
        }
        
        //
        let dateFmt = DateFormatter()
        dateFmt.dateFormat = "MM / dd"
        let dateStr = dateFmt.string(from: Date())
        
        let dateLabel = UILabel(title: dateStr, color: UIColor(r: 209, g: 227, b: 252), size: 18.IMGPX())
        bgImgView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(todayLabel).offset(3.IMGPX())
            make.top.equalTo(todayLabel.snp.bottom).offset(10.IMGPX())
        }
        
        //
        mlLabel = UILabel(title: "\(TodayViewModel.getTodayCount()) ML", color: .white, size: 30.IMGPX(), weight: .medium)
        bgImgView.addSubview(mlLabel)
        mlLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(77.IMGPX() + NEW_AREA)
        }
        
        //
        let pingziImg = UIImageView(image: UIImage(named: "pingzi"))
        bgImgView.addSubview(pingziImg)
        pingziImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(mlLabel.snp.bottom).offset(25.IMGPX())
            make.width.equalTo(223.IMGPX())
            make.height.equalTo(313.IMGPX())
        }
        
        //
        let drinkBtn = UIButton(type: .custom)
        drinkBtn.setBackgroundImage(UIImage(named: "drinkBtn"), for: .normal)
        drinkBtn.addTarget(self, action: #selector(drinkBtnClick), for: .touchUpInside)
        bgImgView.addSubview(drinkBtn)
        drinkBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(-8.IMGPX() - NEW_AREA*0.5)
            make.width.equalTo(264.IMGPX())
            make.height.equalTo(82.IMGPX())
        }
        
        let drinkLabel = UILabel(title: "喝水", color: UIColor(r: 52, g: 71, b: 95), size: 25.IMGPX(), weight: .medium)
        drinkBtn.addSubview(drinkLabel)
        drinkLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(drinkBtn)
            make.centerY.equalTo(drinkBtn).offset(-3.IMGPX())
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
