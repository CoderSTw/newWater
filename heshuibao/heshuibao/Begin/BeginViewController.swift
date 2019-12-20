//
//  BeginViewController.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class BeginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setup()
    
    }
    
    private func setup() {
        //
        let indicatorView = BeginIndicatorView()
        indicatorView.setPageNum(num: 0)
        view.addSubview(indicatorView)
        
        //
        let mainView = BeginMainView()
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(145.imgSize())
            make.bottom.equalTo(-230.imgSize())
        }
    }

}
