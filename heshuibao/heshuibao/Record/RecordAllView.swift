//
//  RecordAllView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class RecordAllView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    lazy var items = CoreDataManager.shared.getAllRecordItems()
    private var tableView: UITableView!
    private var noneview: RecordNoneView?
    
    //
    private func setup() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReocrdAllCell.self, forCellReuseIdentifier: "ReocrdAllCell")
        tableView.rowHeight = 68.IMGPX()
        tableView.separatorStyle = .none
        tableView.backgroundColor = COLOR_BGCOLOR
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    public func reloadData() {
        
        items = CoreDataManager.shared.getAllRecordItems()
        if items.count == 0 {
            // 展示nonelabel
            if noneview == nil {
                noneview = RecordNoneView()
                noneview?.name = "暂无全部记录，记得要每天坚持记录哦～"
                tableView.addSubview(noneview!)
                noneview!.snp.makeConstraints { (make) in
                    make.centerX.equalTo(tableView)
                    make.centerY.equalTo(tableView.snp_centerY).offset(-100.IMGPX())
                }
            }
        }else {
            if noneview != nil {
                noneview!.removeFromSuperview()
                noneview = nil
            }
        }
    }

}

extension RecordAllView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReocrdAllCell", for: indexPath) as! ReocrdAllCell
        
        cell.item = items.reversed()[indexPath.row]
        
        return cell
    }
    
    
}
