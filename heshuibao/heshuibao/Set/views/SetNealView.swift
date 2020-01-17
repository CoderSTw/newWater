//
//  SetNealView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/16.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit

class SetNealView: UIView, UITextFieldDelegate {

    override init(frame: CGRect) {
        super.init(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var bgView: UIView!
    private var bottomView: UIView!
    private var titleLabel: UILabel!
    private var textfield: UITextField!
    var nealviewOKBlock: (()->())?
    
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
        titleLabel = UILabel(title: "请输入您的昵称", color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX())
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
        
        let oklabel = UILabel(title: "确定", color: .white, size: 15.IMGPX(), weight: .medium)
        okBtn.addSubview(oklabel)
        oklabel.snp.makeConstraints { (make) in
            make.center.equalTo(okBtn)
        }
        
        textfield = UITextField()
        textfield.text = "\(UserDefaults.standard.string(forKey: NEAL_NAME_KEY)!)"
        textfield.delegate = self
        bottomView.addSubview(textfield)
        textfield.snp.makeConstraints { (make) in
            make.center.equalTo(bottomView)
            make.width.equalTo(300.IMGPX())
            make.height.equalTo(40.IMGPX())
        }
        
        let lineview = UIView()
        lineview.backgroundColor = COLOR_DETAILTEXTCOLOR
        textfield.addSubview(lineview)
        lineview.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(textfield)
            make.height.equalTo(0.5.IMGPX())
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        UIView.animate(withDuration: 0.3) {
            self.bottomView.transform = .init(translationX: 0, y: -280.IMGPX()-NEW_AREA)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        UIView.animate(withDuration: 0.3) {
            UIView.animate(withDuration: 0.3) {
                self.bottomView.transform = .identity
            }
        }
        
        return true
    }
    
    @objc func tap() {
        if textfield.isFirstResponder==true {
            textfield.resignFirstResponder()
            UIView.animate(withDuration: 0.3) {
                self.bottomView.transform = .identity
            }
        }
    }
    
    @objc func okBtnClick() {
        
        tap()
        
        // 改名啊
        if (textfield.text == "") {
            WLHUD.shareHud().showWithError(name: "请输入昵称")
            return
        }else {
            UserDefaults.standard.set(textfield.text, forKey: NEAL_NAME_KEY)
        }
        
        // 通知外界
        self.nealviewOKBlock?()
        
        // 退出
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    public func show() {
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(UIApplication.shared.keyWindow?.rootViewController?.view ?? UIView())
        }
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.bgView.alpha = 0.2
            self.bottomView.transform = .identity
        }) { (_) in
        }
    }

}
