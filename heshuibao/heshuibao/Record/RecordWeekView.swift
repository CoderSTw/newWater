//
//  RecordWeekView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/25.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class RecordWeekView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private var items: Array<RecordSnpItem>!
    private var tableView: UITableView!
    private var topview: RecordWeekTopView!
    private let times = ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"]
    
    //
    private func setup() {
        
        // 0. items
        items = RecordViewModel.getWeekItems()
        
        // 1. topview
        topview = RecordWeekTopView()
        topview.items = items
        addSubview(topview)
        topview.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(220.IMGPX())
        }
        
        // 2. label
        let titleView = RecordTitleLabelView(titleName: "本周饮水详情：")
        addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(25.IMGPX())
            make.top.equalTo(topview.snp_bottom).offset(20.IMGPX())
            make.width.equalTo(SCREEN_WIDTH - 25.IMGPX())
            make.height.equalTo(30.IMGPX())
        }
        
        // 3. tableView
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ReocrdWeekCell.self, forCellReuseIdentifier: "RecordWeekCell")
        tableView.rowHeight = 68.IMGPX()
        tableView.separatorStyle = .none
        tableView.backgroundColor = COLOR_BGCOLOR
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(titleView.snp_bottom).offset(15.IMGPX())
        }
    }
    
    func reloadData() {
        items = RecordViewModel.getWeekItems()
        tableView.reloadData()
        topview.items = items
    }

}

extension RecordWeekView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordWeekCell", for: indexPath) as! ReocrdWeekCell
        
        cell.timeLabel.text = times[indexPath.row]
        cell.item = items[indexPath.row]
        
        return cell
    }
}

class RecordWeekTopView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    var items: Array<RecordSnpItem>? {
        didSet {
            for i in 0..<items!.count {
                let zhuview = zhuViews[i]
                let starview = starViews[i]
                let item = items![i]
                
                if item.progress! >= 100 {
                    starview.isHidden = false
                }else {
                    starview.isHidden = true
                }
                
                if item.mlVlalue! == 0 {
                    zhuview.snp.updateConstraints { (make) in
                        make.height.equalTo(6.IMGPX())
                    }
                }else {
                    zhuview.snp.updateConstraints { (make) in
                        var progcount = item.progress
                        if progcount ?? 0>=130 { progcount = 130 }
                        make.height.equalTo(CGFloat(progcount!)*0.9.IMGPX())
                    }
                }
            }
        }
    }
    
    //
    private var zhuViews = Array<UIView>()
    private var starViews = Array<UIImageView>()
    
    //
    private func setup() {
        //
        let lineView = UIImageView(image: UIImage(named: "weekLine"))
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(35.IMGPX())
            make.top.equalTo(40.IMGPX())
            make.width.equalTo(302.IMGPX())
            make.height.equalTo(136.IMGPX())
        }
        
        //
        let target = NSString(format: "%.2f L", CGFloat(TodayViewModel.getTargetCount())/1000) as String
        let half = NSString(format: "%.2f L", CGFloat(TodayViewModel.getTargetCount())/2000) as String
        let max = NSString(format: "%.2f L", CGFloat(TodayViewModel.getTargetCount())/1000 + 0.5) as String
        let titles = ["0 L", half, target, max]
        for i in 0..<4 {
            let label = UILabel(title: titles[i], color: COLOR_DETAILTEXTCOLOR, size: 13.IMGPX())
            addSubview(label)
            label.snp.makeConstraints { (make) in
                make.left.equalTo(lineView.snp_right).offset(15)
                make.centerY.equalTo(lineView.snp_bottom).offset(-3.IMGPX()+CGFloat(i) * -45.IMGPX())
            }
        }
        
        //
        let width = 15.IMGPX()
        let margin = (302.IMGPX() - (7.0*width)) / 8.0
        let weeks = ["W", "T", "W", "T", "F", "S", "S"]
        for i in 0..<7 {
            let label = UILabel(title: weeks[i], color: COLOR_DETAILTEXTCOLOR, size: 13.IMGPX())
            addSubview(label)
            label.snp.makeConstraints { (make) in
                make.top.equalTo(lineView.snp_bottom).offset(20.IMGPX())
                make.left.equalTo(lineView).offset(margin + CGFloat(i) * (width + margin))
                make.width.equalTo(width)
            }
            
            let zhuView = UIView()
            zhuView.cornerRadius(radius: 2.IMGPX())
            zhuView.backgroundColor = COLORT_MAIN_BLUE
            addSubview(zhuView)
            zhuView.snp.makeConstraints { (make) in
                make.centerX.equalTo(label)
                make.bottom.equalTo(lineView)
                make.width.equalTo(10.IMGPX())
                make.height.equalTo(90.IMGPX())
            }
            zhuViews.append(zhuView)
            
            let starView = UIImageView(image: UIImage(named: "weekSatr"))
            addSubview(starView)
            starView.snp.makeConstraints { (make) in
                make.centerX.equalTo(zhuView)
                make.bottom.equalTo(zhuView.snp_top).offset(-5.IMGPX())
                make.width.height.equalTo(12.IMGPX())
            }
            starViews.append(starView)
        }
    }
}
