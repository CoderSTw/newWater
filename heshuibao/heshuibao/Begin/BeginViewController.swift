//
//  BeginViewController.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class BeginViewController: UIViewController {
    
    // 属性
    private var pageNum = 0
    private var indicatorView: BeginIndicatorView!
    private var mainView: BeginMainView!
    private var nextBtn: UIButton!
    private var nextLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setup()
    
    }
    
    private func setup() {
        //
        indicatorView = BeginIndicatorView()
        indicatorView.setPageNum(num: pageNum)
        view.addSubview(indicatorView)
        
        //
        mainView = BeginMainView()
        mainView.setPageNum(num: pageNum)
        view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)
            make.top.equalTo(145.imgSize())
            make.bottom.equalTo(-230.imgSize())
        }
        
        //
        nextBtn = UIButton(type: .system)
        nextBtn.setBackgroundImage(UIImage(named: "nextBtn"), for: .normal)
        nextBtn.addTarget(self, action: #selector(nextBtnClick), for: .touchUpInside)
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.bottom.equalTo(-80.imgSize())
            make.width.equalTo(340.imgSize())
            make.height.equalTo(72.imgSize())
        }
        
        nextLabel = UILabel(title: "下一步", color: .white, size: 18.imgSize(), weight: .medium)
        nextBtn.addSubview(nextLabel)
        nextLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(nextBtn)
            make.centerY.equalTo(nextBtn).offset(-3.imgSize())
        }
    }

}

extension BeginViewController {
    @objc func nextBtnClick() {
        pageNum = pageNum + 1
        if pageNum==6 {
            // 开启通知哦！
            dismiss(animated: true, completion: nil)
            return
        }
        
        indicatorView.setPageNum(num: pageNum)
        mainView.setPageNum(num: pageNum)
        
        if pageNum==5 {lastBtn()}
    }
    
    @objc func jumpBtnClick() {
        // 跳转到主界面？？？
        //TODO:
        dismiss(animated: true, completion: nil)
    }
    
    private func lastBtn() {
        nextBtn.snp.updateConstraints { (make) in
            make.bottom.equalTo(-150.imgSize())
        }
        nextLabel.text = "开启通知并进入软件"
        
        let jumpLabel = UILabel(title: "稍后开启通知", color: COLOR_DETAILTEXTCOLOR, size: 18.imgSize())
        view.addSubview(jumpLabel)
        jumpLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(nextBtn)
            make.top.equalTo(nextBtn.snp_bottom).offset(30.imgSize())
        }
        
        let jumpBtn = UIButton(type: .system)
        jumpBtn.addTarget(self, action: #selector(jumpBtnClick), for: .touchUpInside)
        view.addSubview(jumpBtn)
        jumpBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(jumpLabel)
        }
    }
}
