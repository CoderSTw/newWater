//
//  RecordAllView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/26.
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
    
    //
    private func setup() {
        
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReocrdAllCell.self, forCellReuseIdentifier: "ReocrdAllCell")
        tableView.rowHeight = 68.imgSize()
        tableView.separatorStyle = .none
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

}

extension RecordAllView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.getAllRecordItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReocrdAllCell", for: indexPath) as! ReocrdAllCell
        
        cell.item = items.reversed()[indexPath.row]
        
        return cell
    }
    
    
}
