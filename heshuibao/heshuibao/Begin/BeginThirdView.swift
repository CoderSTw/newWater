//
//  BeginThirdView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/22.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class BeginThirdView: UIView, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: THIRD_CELL_KEY) as! ComentTextCell
        
        cell.titleName = titleNames[indexPath.row]
        if indexPath.row == oldRow {
            cell.isChecked = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let oldCell = tableView.cellForRow(at: IndexPath(row: oldRow, section: 0)) as! ComentTextCell
        oldCell.isChecked = false
        
        let cell = tableView.cellForRow(at: indexPath) as! ComentTextCell
        cell.isChecked = true
        
        oldRow = indexPath.row
        
        UserDefaults.standard.set(indexPath.row, forKey: SPORT_HABBIT_KEY)
    }
    
    //
    private let THIRD_CELL_KEY = "THIRD_CELL_KEY"
    private var oldRow = 0
    private let titleNames = ["经常锻炼", "偶尔锻炼", "不常锻炼", "暂时保密"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
     
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComentTextCell.self, forCellReuseIdentifier: THIRD_CELL_KEY)
        tableView.separatorStyle = .none
        tableView.rowHeight = 65.IMGPX()
        tableView.isScrollEnabled = false
        tableView.selectRow(at: IndexPath(row: oldRow, section: 0), animated: false, scrollPosition: .none)
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(30.IMGPX())
            make.right.equalTo(-30.IMGPX())
            make.top.equalTo(40.IMGPX())
            make.bottom.equalTo(self)
        }
    }

}
