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
    
    private func setup() {
        // 1. top
        let todayTopView = TodayTopView()
        todayTopView.delete(self)
        view.addSubview(todayTopView)
        todayTopView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(650.imgSize())
        }

        
        // 2. bottom
    }
    
}

extension TodayViewController: TodayTopViewDelegate {
    func TodayTopViewDidClickDrinkBtn() {
        // 弹出底部的窗口哦
    }
}
