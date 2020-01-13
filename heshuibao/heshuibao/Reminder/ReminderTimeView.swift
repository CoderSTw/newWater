//
//  ReminderTimeView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/26.
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
    private var selRows = Array<Int>()
    
    //
    private func setup() {
        //
        let titleLabel = UILabel(title: "当前选中时间：", color: COLOR_MAINTEXTCOLOR, size: 18.imgSize())
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.top.equalTo(35.imgSize())
        }
        
        //
        let selTimeLabel = UILabel(title: "08:00  09:00", color: COLOR_DETAILTEXTCOLOR, size: 13.imgSize())
        addSubview(selTimeLabel)
        selTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(15.imgSize())
            make.right.equalTo(-30.imgSize())
        }
        
        //
        myswitchBtn = UIButton()
        myswitchBtn.setBackgroundImage(UIImage(named: "timeBtn"), for: .normal)
        myswitchBtn.setBackgroundImage(UIImage(named: "timeBtnSel"), for: .selected)
        myswitchBtn.addTarget(self, action: #selector(swithBtnClick), for: .touchUpInside)
        myswitchBtn.isSelected = UserDefaults.standard.bool(forKey: REMINDER_STATUS_KEY)
        addSubview(myswitchBtn)
        myswitchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-30.imgSize())
            make.centerY.equalTo(titleLabel.snp_bottom)
            make.width.equalTo(40.imgSize())
            make.height.equalTo(25.imgSize())
        }
        
        //
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComentTextCell.self, forCellReuseIdentifier: "Reminder_Time_Cell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 65.imgSize()
        tableView.showsVerticalScrollIndicator = false
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.right.equalTo(-30.imgSize())
            make.bottom.equalTo(self)
            make.top.equalTo(selTimeLabel.snp_bottom).offset(45.imgSize())
        }
    }
}

extension ReminderTimeView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reminder_Time_Cell") as! ComentTextCell
        
        cell.titleName = indexPath.row<3 ? "0\(indexPath.row+7) : 00" : "\(indexPath.row+7) : 00"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ComentTextCell
        
        for i in 0..<selRows.count {
            let row = selRows[i]
            if indexPath.row == row {
                // 有选中的
                cell.isSelected = false
                selRows.remove(at: i) //
                print(selRows)
                return
            }
        }
        
        selRows.append(indexPath.row)
        print(selRows)
        cell.isSelected = true
        
    }
    
    @objc func swithBtnClick() {
        myswitchBtn.isSelected = !UserDefaults.standard.bool(forKey: REMINDER_STATUS_KEY)
        UserDefaults.standard.set(myswitchBtn.isSelected, forKey: REMINDER_STATUS_KEY)
    }
}
