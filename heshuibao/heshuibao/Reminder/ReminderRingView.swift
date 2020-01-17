//
//  ReminderRingView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class ReminderRingView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    private let names = ["默认", "温馨", "科幻", "开瓶盖", "风之谷", "竹之韵", "跳动", "倾心", "多啦A梦", "恋爱循环", "风琴", "水珠", "节奏", "明亮", "电子", "屁声", "倒水", "轻盈", "未来", "冒泡", "滴入水中", "喵～", "波动", "琴刷", "波浪", "科技", "弹跳", "智能", "轻拨", "渐慢", "倒影", "快速", "风铃", "颤动", "电波", "跳跃", "鸡鸣", "小黄人", "滑行", "响指", "重复", "嘟嘟嘟", "皮卡丘", "仙境", "特别关心", "三连音"]
    private var selRow = UserDefaults.standard.integer(forKey: RING_SEL_ROW_KEY)
    private let reminderPlayer = ReminderPlayer()
    
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
        tableView.rowHeight = 65.IMGPX()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = COLOR_BGCOLOR
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(30.IMGPX())
            make.right.equalTo(-30.IMGPX())
            make.bottom.top.equalTo(self)
        }
    }

}

extension ReminderRingView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reminder_Ring_Cell") as! ComentTextCell
        
        cell.titleName = names[indexPath.row]
        cell.imgName = "play"
        if indexPath.row==selRow {
            cell.isChecked = true
        }else {
            cell.isChecked = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        FullMannager.shareManager().loadFull(vc: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {
            DispatchQueue.main.async {
                let oldcell = tableView.cellForRow(at: IndexPath(row: self.selRow, section: 0)) as? ComentTextCell ?? ComentTextCell()
                oldcell.isChecked = false
                
                let cell = tableView.cellForRow(at: indexPath) as! ComentTextCell
                cell.isChecked = true
                self.selRow = indexPath.row
                UserDefaults.standard.set(self.selRow, forKey: RING_SEL_ROW_KEY)
                UserDefaults.standard.synchronize()
                
                // 播放音乐
                self.reminderPlayer.stopPlay()
                let ringName = "\(indexPath.row==0 ? 0 : indexPath.row+9).mp3"
                self.reminderPlayer.startPlayWithName(name: ringName)
                
                // 重新创建通知
                ReminderManager.shareManager().addReminder()
            }
        }
    }
}
