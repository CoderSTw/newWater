//
//  BeginMainView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class BeginMainView: UIView {
    
    private var scrollView: UIScrollView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private let titleNames = ["请选择您的性别", "请选择您的身高", "请选择您的体重", "请选择您的运动习惯", "推荐每日饮水目标", "每日按时提醒饮水"]
    private var titleLabel: UILabel!
    private var detailLabel: UILabel!
    private var fourthView: BeginFourthView!
    
    private func setup() {
        //
        titleLabel = UILabel(title: titleNames[0], color: COLOR_MAINTEXTCOLOR, size: 30.imgSize(), weight: .medium)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.top.equalTo(self)
        }
        
        //
        detailLabel = UILabel(title: "请正确填写您的信息以便与软件推算出您每日推荐的饮水量。", color: COLOR_DETAILTEXTCOLOR, size: 18.imgSize())
        detailLabel.numberOfLines = 0
        detailLabel.changeLineSpace(space: 10.imgSize())
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(15.imgSize())
            make.right.equalTo(-30.imgSize())
        }
        
        //
        scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH*6, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isScrollEnabled = false
        addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.width.equalTo(self)
            make.top.equalTo(detailLabel.snp_bottom).offset(50.imgSize())
            make.height.equalTo(400.imgSize())
        }
        
        //
        setupDetailViews()
    }
    
    // 设置每一页的view
    private func setupDetailViews() {
        // 0
        let zeroView = BeginZeroView()
        scrollView.addSubview(zeroView)
        zeroView.snp.makeConstraints { (make) in
            make.left.top.equalTo(scrollView)
            make.width.height.equalTo(scrollView)
        }
        
        // 1
        let firstView = BeginFirstView()
        scrollView.addSubview(firstView)
        firstView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView).offset(SCREEN_WIDTH)
            make.width.height.top.equalTo(scrollView)
        }
        
        // 2
        let secondView = BeginSecondView()
        scrollView.addSubview(secondView)
        secondView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView).offset(SCREEN_WIDTH*2)
            make.width.height.top.equalTo(scrollView)
        }
        
        // 3
        let thirdView = BeginThirdView()
        scrollView.addSubview(thirdView)
        thirdView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView).offset(SCREEN_WIDTH*3)
            make.width.height.top.equalTo(scrollView)
        }
        
        // 4
        fourthView = BeginFourthView()
        scrollView.addSubview(fourthView)
        fourthView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView).offset(SCREEN_WIDTH*4)
            make.width.height.top.equalTo(scrollView)
        }
        
        // 5
        let drinkImg = UIImageView(image: UIImage(named: "iconImg"))
        scrollView.addSubview(drinkImg)
        drinkImg.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView).offset(SCREEN_WIDTH*5 + 118.imgSize())
            make.top.equalTo(scrollView)
            make.width.equalTo(188.imgSize())
            make.height.equalTo(253.imgSize())
            
        }
    }
    
    // 设置页数
    func setPageNum(num: Int) {
        if num==4 {
            fourthView.reloadData()
        }
        
        if num==5 {
            detailLabel.text = "开启每日通知提醒，具体时间、铃声、提示语可稍后进入设置中自定义设置。"
        }
        
        scrollView.setContentOffset(CGPoint(x: SCREEN_WIDTH*CGFloat(num), y: 0), animated: true)
        titleLabel.text = titleNames[num]
    }
}


