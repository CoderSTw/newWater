//
//  SetTargetView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/16.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit

class SetTargetView: UIView, UITextFieldDelegate {

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
    private var sugBtn: SetTargetButton!
    private var autoBtn: SetTargetButton!
    private var textField: UITextField!
    var targetViewTap: (()->())?
    
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
        titleLabel = UILabel(title: "请选择每日喝水目标", color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX())
        bottomView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(25.IMGPX())
            make.top.equalTo(25.IMGPX())
        }
        
        // 推荐
        sugBtn = SetTargetButton(name: "根据您的身高体重推算（\(UserDefaults.standard.integer(forKey: HEIGHT_ROW_KEY)+150) cm 、 \(UserDefaults.standard.integer(forKey: WEIGHT_ROW_KEY) + 30) kg）：", mainname: "\(TodayViewModel.getTuijianTargetCount()) ML")
        sugBtn.addTarget(self, action: #selector(sugBtnClick), for: .touchUpInside)
        bottomView.addSubview(sugBtn)
        sugBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomView)
            make.top.equalTo(titleLabel.snp_bottom).offset(35.IMGPX())
            make.width.equalTo(325.IMGPX())
            make.height.equalTo(90.IMGPX())
        }
        
        // 自定义
        autoBtn = SetTargetButton(name: "自定义每日喝水目标：", mainname: "\(TodayViewModel.getAutoTargetCount()) ML")
        autoBtn.addTarget(self, action: #selector(autoBtnClick), for: .touchUpInside)
        bottomView.addSubview(autoBtn)
        autoBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomView)
            make.top.equalTo(sugBtn.snp_bottom).offset(35.IMGPX())
            make.width.equalTo(325.IMGPX())
            make.height.equalTo(90.IMGPX())
        }
        
        //
        textField = UITextField()
        bottomView.addSubview(textField)
        textField.keyboardType = .numberPad
        textField.delegate = self
        textField.textColor = .clear
        textField.alpha = 0
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        textField.text = "\(TodayViewModel.getAutoTargetCount())"
        textField.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(bottomView)
            make.height.equalTo(10.IMGPX())
        }
        
        if (UserDefaults.standard.bool(forKey: IS_AUTO_KEY)==true) {
            autoBtn.isSelected = true
            sugBtn.isSelected = false
        }else {
            autoBtn.isSelected = false
            sugBtn.isSelected = true
        }
    }
    
    @objc func sugBtnClick() {
        sugBtn.isSelected = true
        autoBtn.isSelected = false
        UserDefaults.standard.set(false, forKey: IS_AUTO_KEY)
    }
    
    @objc func autoBtnClick() {
        sugBtn.isSelected = false
        autoBtn.isSelected = true
        
        // 这里输入
        UIView.animate(withDuration: 0.3) {
            self.bottomView.transform = .init(translationX: 0, y: -280.IMGPX()-NEW_AREA)
        }
        textField.becomeFirstResponder()
        
        UserDefaults.standard.set(true, forKey: IS_AUTO_KEY)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.text == "0") {
            textField.text = ""
        }
        return true
    }
    
    @objc func textFieldDidChange(_ textfield : UITextField) {
        autoBtn.setMainText(string: (textField.text ?? "") + " ML")
    }
    
    
    @objc func tap() {
        
        if (textField.isFirstResponder==true) {
            textField.resignFirstResponder()
            UIView.animate(withDuration: 0.3) {
                self.bottomView.transform = .identity
            }
            if (textField.text == "") {
                autoBtn.setMainText(string: "0" + " ML")
                TodayViewModel.setAutoTargetCount(value: 0)
            }
            TodayViewModel.setAutoTargetCount(value: Int(textField.text ?? "0") ?? 0)
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 0
        }) { (_) in
            // 这里通知外面改变啊
            self.targetViewTap?()
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

class SetTargetButton: UIButton {
    
    init(name: String, mainname: String) {
        super.init(frame: .zero)
        setup(name: name, mainname: mainname)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setMainText(string: String) {
        mainLabel.text = string
    }
    
    private var mainLabel: UILabel!
    
    private func setup(name: String, mainname: String) {
        setBackgroundImage(UIImage(named: "settarget"), for: .normal)
        setBackgroundImage(UIImage(named: "settargets"), for: .selected)
        setBackgroundImage(UIImage(named: "settargets"), for: .highlighted)
        
        let label = UILabel(title: name, color: COLOR_BGCOLOR, size: 12.IMGPX())
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(15.IMGPX())
            make.top.equalTo(10.IMGPX())
        }
        
        mainLabel = UILabel(title: mainname, color: COLOR_BGCOLOR, size: 20.IMGPX(), weight: .medium)
        addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(-15.IMGPX())
        }
    }
}
