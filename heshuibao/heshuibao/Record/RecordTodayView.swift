//
//  RecordTodayView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/25.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class RecordTodayView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private var tableView: UITableView!
    
    //
    private func setup() {
     
        // topview
        let topview = TodayBottomView()
        addSubview(topview)
        topview.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(160.imgSize())
            make.top.equalTo(self)
        }
        
        // label
        let titleView = RecordTitleLabelView(titleName: "今日饮水详情：")
        addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(25.imgSize())
            make.top.equalTo(topview.snp_bottom).offset(20.imgSize())
            make.width.equalTo(SCREEN_WIDTH - 25.imgSize())
            make.height.equalTo(30.imgSize())
        }
        
        // tableView
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecordTodayCell.self, forCellReuseIdentifier: "RecordTodayCell")
        tableView.rowHeight = 70.imgSize()
        tableView.separatorStyle = .none
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(titleView.snp_bottom).offset(0.imgSize())
        }
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}

extension RecordTodayView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodayAddItem.GetTodayItemArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTodayCell", for: indexPath) as! RecordTodayCell
        
        cell.todayAddItem = TodayAddItem.GetTodayItemArray()[indexPath.row]
        
        return cell
    }
    
    
}

class RecordTitleLabelView: UIView {
    init(titleName: String) {
        super.init(frame: CGRect.zero)
        
        let view = UIView()
        view.cornerRadius(radius: 1.imgSize())
        view.backgroundColor = COLORT_MAIN_BLUE
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.width.equalTo(2.imgSize())
            make.height.equalTo(12.imgSize())
        }
        
        let label = UILabel(title: titleName, color: COLOR_MAINTEXTCOLOR, size: 18.imgSize())
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(15.imgSize())
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
