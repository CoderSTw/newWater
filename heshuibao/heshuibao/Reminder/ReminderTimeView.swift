//
//  ReminderTimeView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class ReminderTimeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private var myswitchBtn: UIButton!
    private var selRows = UserDefaults.standard.object(forKey: TIME_SEL_ROW_KEY) as? Array<Int> ?? []
    private var selString: String = ""
    private var selTimeLabel: UILabel!
    private var bgbtn: SetTargetButton!
    
    //
    private func setup() {
        
        bgbtn = SetTargetButton(name: "", mainname: "")
        bgbtn.alpha = 0.2
        addSubview(bgbtn)
        bgbtn.snp.makeConstraints { (make) in
            make.width.equalTo(395.IMGPX())
            make.height.equalTo(105.IMGPX())
            make.top.equalTo(17.IMGPX())
            make.centerX.equalTo(self)
        }
        
        
        //
        let titleLabel = UILabel(title: "当前选中时间：", color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX())
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30.IMGPX())
            make.top.equalTo(35.IMGPX())
        }
        
        //
        selTimeLabel = UILabel(title: selString, color: COLOR_DETAILTEXTCOLOR, size: 13.IMGPX())
        selTimeLabel.numberOfLines = 3
        addSubview(selTimeLabel)
        selTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(15.IMGPX())
            make.right.equalTo(-30.IMGPX())
        }
        
        loadStrings()
        
        //
        myswitchBtn = UIButton()
        myswitchBtn.setBackgroundImage(UIImage(named: "timeBtn"), for: .normal)
        myswitchBtn.setBackgroundImage(UIImage(named: "timeBtnSel"), for: .selected)
        myswitchBtn.addTarget(self, action: #selector(swithBtnClick), for: .touchUpInside)
        myswitchBtn.isSelected = UserDefaults.standard.bool(forKey: REMINDER_STATUS_KEY)
        addSubview(myswitchBtn)
        myswitchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-30.IMGPX())
            make.centerY.equalTo(titleLabel.snp_bottom)
            make.width.equalTo(40.IMGPX())
            make.height.equalTo(25.IMGPX())
        }
        
        //
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComentTextCell.self, forCellReuseIdentifier: "Reminder_Time_Cell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 65.IMGPX()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = COLOR_BGCOLOR
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(30.IMGPX())
            make.right.equalTo(-30.IMGPX())
            make.bottom.equalTo(self)
            make.top.equalTo(selTimeLabel.snp_bottom).offset(45.IMGPX())
        }
    }
    
    private func loadStrings() {
        selString = ""
        var a = selRows
        a.sort(by: <)
        for selrow in a {
            selString.append(selrow<3 ? "0\(selrow+7) : 00    " : "\(selrow+7) : 00    ")
        }
        selTimeLabel.text = selString
    }
    
    public func checkStatus() {
        myswitchBtn.isSelected = UserDefaults.standard.bool(forKey: REMINDER_STATUS_KEY)
        bgbtn.isSelected = myswitchBtn.isSelected
    }
}

extension ReminderTimeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reminder_Time_Cell") as! ComentTextCell
        
        cell.titleName = indexPath.row<3 ? "0\(indexPath.row+7) : 00" : "\(indexPath.row+7) : 00"
        cell.imgName = "remindertime"
        cell.isChecked = false
        for selfrow in selRows {
            if indexPath.row == selfrow {
                cell.isChecked = true
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ComentTextCell
        
        cell.isChecked = !cell.isChecked
        if cell.isChecked == true {
            selRows.append(indexPath.row)
        }else {
            print("\(selRows)")
            let count = selRows.count
            for i in 0..<count {
                if indexPath.row==selRows[i] {
                    selRows.remove(at: i)
                    UserDefaults.standard.set(selRows, forKey: TIME_SEL_ROW_KEY)
                    loadStrings()
                    
                    // 重新创建通知
                    ReminderManager.shareManager().addReminder()
                    return
                }
            }
        }
        
        UserDefaults.standard.set(selRows, forKey: TIME_SEL_ROW_KEY)
        loadStrings()
        // 重新创建通知
        ReminderManager.shareManager().addReminder()
    }
    
    @objc func swithBtnClick() {
        
        // 这里先检查
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
                    self.bgbtn.isSelected = self.myswitchBtn.isSelected
                    
                    if self.myswitchBtn.isSelected==true {
                        ReminderManager.shareManager().addReminder()
                        WLHUD.shareHud().showWithSuccess(name: "开启通知成功！", Dismiss: {})
                    }else {
                        ReminderManager.shareManager().clearAllReminder()
                        WLHUD.shareHud().showWithSuccess(name: "关闭通知成功！", Dismiss: {})
                    }
                }
            }
        }else {
            self.myswitchBtn.isSelected = !UserDefaults.standard.bool(forKey: REMINDER_STATUS_KEY)
            UserDefaults.standard.set(self.myswitchBtn.isSelected, forKey: REMINDER_STATUS_KEY)
            self.bgbtn.isSelected = self.myswitchBtn.isSelected
            
            if self.myswitchBtn.isSelected==true {
                ReminderManager.shareManager().addReminder()
                WLHUD.shareHud().showWithSuccess(name: "开启通知成功！", Dismiss: {})
            }else {
                ReminderManager.shareManager().clearAllReminder()
                WLHUD.shareHud().showWithSuccess(name: "关闭通知成功！", Dismiss: {})
            }
        }
        
        
    }
}
