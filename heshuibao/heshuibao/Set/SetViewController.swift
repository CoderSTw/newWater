//
//  SetViewController.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = COLOR_BGCOLOR
        
        setup()
    }
    
    private var topview: SetTopView!
    private var bottomview: SetBottomView!
    
    private func setup() {
        //
        topview = SetTopView()
        view.addSubview(topview)
        topview.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(149.IMGPX() + NEW_AREA)
        }
        topview.topviewClickImg = { [weak self] in
            self?.SetBottomViewDidClickPersonal()
        }
        
        //
        bottomview = SetBottomView()
        bottomview.delegate = self
        view.addSubview(bottomview)
        bottomview.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.bottom.equalTo(-40-NEW_AREA-60)
            make.top.equalTo(topview.snp_bottom).offset(45.IMGPX())
        }
        
        BannerManager().loadBanner(vc: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = false
        //
        topview.loadImg()
        //
        bottomview.checkStatus()
    }
}

extension SetViewController: SetBottomViewDelegate {
    func SetBottomViewDidClickPersonal() {
        // 跳转
        navigationController?.pushViewController(SetPersonalViewController(), animated: true)
    }
    
    func SetBottomViewDidClickInfo() {
        navigationController?.pushViewController(SetInfoViewController(), animated: true)
    }
}
