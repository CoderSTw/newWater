//
//  RecordTodayView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/25.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit
import PieCharts

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
    private var chartview: PieChart!
    private var textViews = Array<RecordTodayTextView>()
    private let colors = [COLORT_WATER, COLORT_COFFEE, COLORT_MILK, COLORT_TEA, COLORT_COLA]
    private let texts = ["饮水", "咖啡", "牛奶", "茶类", "饮料"]
    private var noneview: RecordNoneView?
    
    //
    private func setup() {
        //
        chartview = PieChart(frame: .init(x: -50.IMGPX(), y: -60.IMGPX(), width: 300.IMGPX(), height: 300.IMGPX()))
        chartview.animDuration = 0.75
        chartview.transform = .init(scaleX: 0.7, y: 0.7)
        addSubview(chartview)
        
        // 这里加五个文本
        for i in 0..<getChartArr().count {
            let view = RecordTodayTextView()
            addSubview(view)
            view.snp.makeConstraints { (make) in
                make.left.equalTo(self.snp_centerX).offset(30.IMGPX())
                make.top.equalTo(30.IMGPX() + CGFloat(i)*25.IMGPX())
                make.width.equalTo(100.IMGPX())
                make.height.equalTo(25.IMGPX())
            }
            textViews.append(view)
        }
        
        
        // label
        let titleView = RecordTitleLabelView(titleName: "今日饮水详情：")
        addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.left.equalTo(25.IMGPX())
            make.top.equalTo(200.IMGPX())
            make.width.equalTo(SCREEN_WIDTH - 25.IMGPX())
            make.height.equalTo(30.IMGPX())
        }
        
        // tableView
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecordTodayCell.self, forCellReuseIdentifier: "RecordTodayCell")
        tableView.rowHeight = 70.IMGPX()
        tableView.separatorStyle = .none
        tableView.backgroundColor = COLOR_BGCOLOR
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(titleView.snp_bottom).offset(0.IMGPX())
        }
    }
    
    func reloadData() {
        
        // 刷新表格
        tableView.reloadData()
        
        // 刷新视图
        var allValues = 0
        for value in getChartArr() {
            allValues += value
        }
        if allValues == 0 {
            // 没有数据
            chartview.clear()
            chartview.models = [ PieSliceModel(value: 1, color: COLORT_WATER) ]
            
            // 展示nonelabel
            if noneview == nil {
                noneview = RecordNoneView()
                noneview?.name = "今日暂无记录，快去喝水吧～"
                tableView.addSubview(noneview!)
                noneview!.snp.makeConstraints { (make) in
                    make.centerX.equalTo(tableView)
                    make.top.equalTo(120.IMGPX())
                }
            }
        }else {
            chartview.clear()
            chartview.models = [
                PieSliceModel(value: Double(getChartArr()[0]), color: COLORT_WATER),
                PieSliceModel(value: Double(getChartArr()[1]), color: COLORT_COFFEE),
                PieSliceModel(value: Double(getChartArr()[2]), color: COLORT_MILK),
                PieSliceModel(value: Double(getChartArr()[3]), color: COLORT_TEA),
                PieSliceModel(value: Double(getChartArr()[4]), color: COLORT_COLA)
            ]
            
            if noneview != nil {
                noneview!.removeFromSuperview()
                noneview = nil
            }
        }
        
        for i in 0..<textViews.count {
            let view = textViews[i]
            view.setColorAndText(color: colors[i], text: "\(texts[i]) : \(getChartArr()[i]) ML")
        }
    }
    
    private func getChartArr() -> [Int] {
        let arr = TodayAddItem.GetTodayItemArray()
        var waterValue = 0
        var coffeeValue = 0
        var milkValue = 0
        var teaValue = 0
        var colaValue = 0
        for item in arr {
            let strArr = item.mlValue.split(separator: " ")
            let value = Int(strArr[0]) ?? 0
            if item.waterName == "水" {
                waterValue += value
            }else if item.waterName == "咖啡" {
                coffeeValue += value
            }else if item.waterName == "牛奶" {
                milkValue += value
            }else if item.waterName == "茶" {
                teaValue += value
            }else if item.waterName == "饮料" {
                colaValue += value
            }
        }
        return [waterValue, coffeeValue, milkValue, teaValue, colaValue]
    }
    
}

class RecordTodayTextView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setColorAndText(color: UIColor, text: String) {
        dot.backgroundColor = color
        label.text = text
    }
    
    private var dot: UIView!
    private var label: UILabel!
    
    private func setup() {
        dot = UIView()
        dot.cornerRadius(radius: 2.IMGPX())
        self.addSubview(dot)
        dot.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.width.height.equalTo(4.IMGPX())
        }
        
        label = UILabel(title: "", color: COLOR_MAINTEXTCOLOR, size: 12.IMGPX())
        self.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(10.IMGPX())
        }
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
        view.cornerRadius(radius: 1.IMGPX())
        view.backgroundColor = COLORT_MAIN_BLUE
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.width.equalTo(2.IMGPX())
            make.height.equalTo(12.IMGPX())
        }
        
        let label = UILabel(title: titleName, color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX())
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(15.IMGPX())
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
