//
//  SetViewController.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setup()
    }
    
    private func setup() {
        //
        let topview = SetTopView()
        view.addSubview(topview)
        topview.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(view)
            make.height.equalTo(200.imgSize())
        }
        
        //
        let bottomview = SetBottomView()
        view.addSubview(bottomview)
        bottomview.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(topview.snp_bottom).offset(45.imgSize())
        }
    }

}
