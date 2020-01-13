//
//  ReminderNoteView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class ReminderNoteView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(tap)))
        
        //
        let titleLabel = UILabel(title: "新增提醒文字：", color: COLOR_MAINTEXTCOLOR, size: 18.imgSize())
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.top.equalTo(35.imgSize())
        }
        
        //
        let textFiele = UITextField()
        textFiele.placeholder = "请输入提醒文字..."
        addSubview(textFiele)
        textFiele.snp.makeConstraints { (make) in
            make.left.equalTo(40.imgSize())
            make.right.equalTo(-35.imgSize())
            make.top.equalTo(titleLabel.snp_bottom).offset(20.imgSize())
            make.height.equalTo(44.imgSize())
        }
        
        //
        let line = UIView()
        line.backgroundColor = COLOR_DETAILTEXTCOLOR
        line.alpha = 0.2
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.right.equalTo(-30.imgSize())
            make.top.equalTo(textFiele.snp_bottom)
            make.height.equalTo(1.imgSize())
        }
        
        //
        let addBtn = UIButton()
        addBtn.setBackgroundImage(UIImage(named: "nextBtn"), for: .normal)
        addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
        addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(line.snp_bottom).offset(45.imgSize())
            make.width.equalTo(158.imgSize())
            make.height.equalTo(40.imgSize())
        }
        
        let addLabel = UILabel(title: "添加", color: .white, size: 15.imgSize(), weight: .medium)
        addSubview(addLabel)
        addLabel.snp.makeConstraints { (make) in
            make.center.equalTo(addBtn)
        }
        
        //
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComentTextCell.self, forCellReuseIdentifier: "Reminder_Note_Cell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 65.imgSize()
        tableView.showsVerticalScrollIndicator = false
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.right.equalTo(-30.imgSize())
            make.bottom.equalTo(self)
            make.top.equalTo(addBtn.snp_bottom).offset(45.imgSize())
        }
    }

}

extension ReminderNoteView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reminder_Note_Cell") as! ComentTextCell
        
        cell.titleName = "哈哈哈哈哈哈哈"
        
        return cell
    }
    
    @objc func tap() {
        
    }
    
    @objc func addBtnClick() {
        
    }
}
