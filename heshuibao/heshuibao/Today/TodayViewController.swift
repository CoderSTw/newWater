//
//  TodayViewController.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit
import StoreKit

class TodayViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = COLOR_BGCOLOR
        
        setup()
        
        BannerManager().loadBanner(vc: self)
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
            make.height.equalTo(582.IMGPX() + NEW_AREA*2 - 50)
        }
        
        // 2. bottom
        bottomView = TodayBottomView()
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(-80 - NEW_AREA)
            make.top.equalTo(todayTopView.snp.bottom)
        }
    }
    
}

extension TodayViewController: TodayTopViewDelegate, TodayDrinkViewDelegate {
    func TodayDrinkViewDidClickDrinkBtn() {
        // 点击了喝水 更新数据哦
        todayTopView?.updateData()
        bottomView?.updateData()
        
        FullMannager.shareManager().loadFull(vc: self) {
        }
    
        var count = UserDefaults.standard.integer(forKey: "count")
        count += 1
        UserDefaults.standard.set(count, forKey: "count")
        
        if (UserDefaults.standard.integer(forKey: "count")==5 || UserDefaults.standard.integer(forKey: "count")==20) {
            
            SKStoreReviewController.requestReview()
        }
    }
    
    func TodayTopViewDidClickDrinkBtn() {
        // 弹出底部的窗口哦
        let drinkView = TodayDrinkView()
        drinkView.delegate = self
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(drinkView)
        drinkView.animate()
    }
}
