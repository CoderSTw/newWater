//
//  SetBottomView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class SetBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private let titles = [["每日提醒", "个人资料", "喝水目标"], ["暗黑模式", "更换语言", "打卡分享", "给我评分", "意见反馈", "关于软件"]]
    private let details = [["", "头像、个性签名等", "2000 ML"], ["", "跟随系统", "", "", "", "v1.0"]]
    private let icons = [["setIcon0", "setIcon1", "setIcon2"], ["setIcon3", "setIcon4", "setIcon5", "setIcon6", "setIcon7", "setIcon8", ]]
    
    //
    private func setup() {
        let tableview = UITableView(frame: CGRect.zero, style: .grouped)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(SetCell.self, forCellReuseIdentifier: "Set_Cell")
        tableview.backgroundColor = .white
        tableview.rowHeight = 65.imgSize()
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(self)
            make.left.equalTo(30.imgSize())
            make.right.equalTo(-30.imgSize())
        }
    }
}

extension SetBottomView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section==0 ? 3 : 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Set_Cell", for: indexPath) as! SetCell
        
        cell.iconName = icons[indexPath.section][indexPath.row]
        cell.titleName = titles[indexPath.section][indexPath.row]
        cell.detailName = details[indexPath.section][indexPath.row]
        
        if (indexPath.row==0) {
            cell.isSwitch = true
            if (indexPath.section==0) {
                cell.myswitchBtn.isSelected = UserDefaults.standard.bool(forKey: REMINDER_STATUS_KEY)
            }else {
                cell.myswitchBtn.isSelected = UserDefaults.standard.bool(forKey: DAEK_MODE_KEY)
            }
        }else {
            cell.isSwitch = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let label = UILabel(title: section==0 ? "基础设置" : "更多设置", color: COLOR_DETAILTEXTCOLOR, size: 13.imgSize())
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(view)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            let cell = tableView.cellForRow(at: indexPath) as! SetCell
            cell.didSelctedCellIndex(index: indexPath.section)
        }
    }
}
