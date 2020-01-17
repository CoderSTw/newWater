//
//  SetCell.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class SetCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = COLOR_BGCOLOR
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    var iconName: String? {
        didSet {
            leftIcon.image = UIImage(named: iconName ?? "setIcon0")
        }
    }
    var titleName: String? {
        didSet {
            titleLabel.text = titleName ?? ""
        }
    }
    var detailName: String? {
        didSet {
            detailLabel.text = detailName ?? ""
        }
    }
    var isSwitch: Bool? {
        didSet {
            if (isSwitch==true) {
                rightCheck.isHidden = true
                myswitchBtn.isHidden = false
            }else {
                rightCheck.isHidden = false
                myswitchBtn.isHidden = true
            }
        }
    }
    
    //
    private var leftIcon: UIImageView!
    private var titleLabel: UILabel!
    private var rightCheck: UIImageView!
    private var detailLabel: UILabel!
    var myswitchBtn: UIButton!
    
    //
    private func setup() {
        //
        let line = UIView()
        line.backgroundColor = UIColor(r: 151, g: 151, b: 151)
        line.alpha = 0.1
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1.IMGPX())
        }
        
        //
        leftIcon = UIImageView(image: UIImage(named: "setIcon0"))
        leftIcon.contentMode = .scaleAspectFit
        addSubview(leftIcon)
        leftIcon.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
            make.width.height.equalTo(23.IMGPX())
        }
        
        //
        titleLabel = UILabel(title: "111", color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX())
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(50.IMGPX())
        }
        
        //
        rightCheck = UIImageView(image: UIImage(named: "setcheck"))
        addSubview(rightCheck)
        rightCheck.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self)
            make.width.equalTo(8.IMGPX())
            make.height.equalTo(11.IMGPX())
        }
        
        //
        detailLabel = UILabel(title: "", color: COLOR_DETAILTEXTCOLOR, size: 13.IMGPX())
        detailLabel.alpha = 0.6
        detailLabel.textAlignment = .right
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-30.IMGPX())
        }
        
        //
        myswitchBtn = UIButton()
        myswitchBtn.setBackgroundImage(UIImage(named: "timeBtn"), for: .normal)
        myswitchBtn.setBackgroundImage(UIImage(named: "timeBtnSel"), for: .selected)
        myswitchBtn.isUserInteractionEnabled = false
        myswitchBtn.isHidden = true
        addSubview(myswitchBtn)
        myswitchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(0.IMGPX())
            make.centerY.equalTo(self)
            make.width.equalTo(40.IMGPX())
            make.height.equalTo(25.IMGPX())
        }
    }
    
    func didSelctedCellIndex(index: Int) {
        if (index==0) {
            
            if (myswitchBtn.isSelected==false) {
                
                ReminderManager.shareManager().checkReminderPower(NoQuanxianHandle: {
                    DispatchQueue.main.async {
                        WLHUD.shareHud().showWithError(name: "请去设置中开启权限！")
                    }
                    return
                }) {
                    DispatchQueue.main.async {
                        self.myswitchBtn.isSelected = !UserDefaults.standard.bool(forKey: REMINDER_STATUS_KEY)
                        UserDefaults.standard.set(self.myswitchBtn.isSelected, forKey: REMINDER_STATUS_KEY)
                        
                        if self.myswitchBtn.isSelected==true {
                            ReminderManager.shareManager().addReminder()
                            DispatchQueue.main.async {
                                
                                WLHUD.shareHud().showWithSuccess(name: "开启通知成功！", Dismiss: {
                                    FullMannager.shareManager().loadFull(vc: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {}
                                })
                            }
                        }else {
                            ReminderManager.shareManager().clearAllReminder()
                            DispatchQueue.main.async {
                            
                                WLHUD.shareHud().showWithSuccess(name: "关闭通知成功！", Dismiss: {
                                    FullMannager.shareManager().loadFull(vc: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {}
                                })
                            }
                        }
                    }
                }
            }else {
                self.myswitchBtn.isSelected = !UserDefaults.standard.bool(forKey: REMINDER_STATUS_KEY)
               UserDefaults.standard.set(self.myswitchBtn.isSelected, forKey: REMINDER_STATUS_KEY)
               
               if self.myswitchBtn.isSelected==true {
                   ReminderManager.shareManager().addReminder()
                   DispatchQueue.main.async {
                       
                       WLHUD.shareHud().showWithSuccess(name: "开启通知成功！", Dismiss: {
                        FullMannager.shareManager().loadFull(vc: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {}
                       })
                   }
               }else {
                   ReminderManager.shareManager().clearAllReminder()
                   DispatchQueue.main.async {
                   
                       WLHUD.shareHud().showWithSuccess(name: "关闭通知成功！", Dismiss: {
                        FullMannager.shareManager().loadFull(vc: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {}
                       })
                   }
               }
            }
            
            
        }else {
            myswitchBtn.isSelected = !UserDefaults.standard.bool(forKey: DAEK_MODE_KEY)
            UserDefaults.standard.set(myswitchBtn.isSelected, forKey: DAEK_MODE_KEY)
            
            let center = NotificationCenter.default
            
            if myswitchBtn.isSelected==true {
                center.post(name: NSNotification.Name(rawValue: "dark_mode"), object: nil, userInfo: ["info" : true])
                WLHUD.shareHud().showWithSuccess(name: "开启暗黑模式成功！", Dismiss: {
                    FullMannager.shareManager().loadFull(vc: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {}
                })
            }else {
                center.post(name: NSNotification.Name(rawValue: "dark_mode"), object: nil, userInfo: ["info" : false])
                WLHUD.shareHud().showWithSuccess(name: "关闭暗黑模式成功！", Dismiss: {
                    FullMannager.shareManager().loadFull(vc: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {}
                })
            }
        }
    }
}
