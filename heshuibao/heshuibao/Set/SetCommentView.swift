//
//  SetCommentView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/14.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit

class SetCommentView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var bgView: UIView!
    var bottomView: UIView!
    private var titleLabel: UILabel!
    var commentviewOKBlock: (()->())?
    var commentviewTapBlock: (()->())?
    var titleName: String? {
        didSet {
            oklabel.text = titleName
        }
    }
    private var oklabel: UILabel!
    
    private func setup() {
        //
        bgView = UIView()
        bgView.alpha = 0
        bgView.backgroundColor = .black
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        //
        bottomView = UIView()
        bottomView.backgroundColor = COLOR_BGCOLOR
        bottomView.cornerRadius(radius: 15.IMGPX())
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(-50.IMGPX())
            make.height.equalTo(382.IMGPX())
            make.width.equalTo(375.IMGPX())
        }
        bottomView.transform = .init(translationX: 0, y: 450.IMGPX())
        
        //
        titleLabel = UILabel(title: "请选择您的身高：", color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX())
        bottomView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(25.IMGPX())
            make.top.equalTo(25.IMGPX())
        }
        
        //
        let okBtn = UIButton()
        okBtn.setBackgroundImage(UIImage(named: "nextBtn"), for: .normal)
        okBtn.addTarget(self, action: #selector(okBtnClick), for: .touchUpInside)
        bottomView.addSubview(okBtn)
        okBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(-25.IMGPX())
            make.width.equalTo(158.IMGPX())
            make.height.equalTo(40.IMGPX())
        }
        
        oklabel = UILabel(title: "确定", color: .white, size: 15.IMGPX(), weight: .medium)
        okBtn.addSubview(oklabel)
        oklabel.snp.makeConstraints { (make) in
            make.center.equalTo(okBtn)
        }
    }
    
    public func show(name: String) {
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(UIApplication.shared.keyWindow?.rootViewController?.view ?? UIView())
        }
        
        titleLabel.text = name
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.bgView.alpha = 0.2
            self.bottomView.transform = .identity
        }) { (_) in
        }
    }
}

extension SetCommentView {
    @objc func tap() {
        commentviewTapBlock?()
    }
    
    @objc func okBtnClick() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
        commentviewOKBlock?()
    }
}
