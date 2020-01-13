//
//  ReminderRingView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class ReminderRingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        //
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComentTextCell.self, forCellReuseIdentifier: "Reminder_Ring_Cell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 65.imgSize()
        tableView.showsVerticalScrollIndicator = false
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.right.equalTo(-30.imgSize())
            make.bottom.top.equalTo(self)
        }
    }

}

extension ReminderRingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reminder_Ring_Cell") as! ComentTextCell
        
        cell.titleName = "\(indexPath.row)"
        
        return cell
    }
}
