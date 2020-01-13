//
//  TodayViewController.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setup()
    }
    
    //
    private var todayTopView: TodayTopView!
    private var bottomView: TodayBottomView!
    
    //
    private func setup() {
        // 1. top
        todayTopView = TodayTopView()
        todayTopView.delegate = self
        view.addSubview(todayTopView)
        todayTopView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(650.imgSize())
        }

        
        // 2. bottom
        bottomView = TodayBottomView()
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(-50 - SafeAreaBottomHeight)
            make.top.equalTo(todayTopView.snp.bottom)
        }
    }
    
}

extension TodayViewController: TodayTopViewDelegate, TodayDrinkViewDelegate {
    func TodayDrinkViewDidClickDrinkBtn() {
        // 点击了喝水 更新数据哦
        todayTopView?.updateData()
        bottomView?.updateData()
        
    }
    
    func TodayTopViewDidClickDrinkBtn() {
        // 弹出底部的窗口哦
        let drinkView = TodayDrinkView()
        drinkView.delegate = self
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(drinkView)
    }
}
