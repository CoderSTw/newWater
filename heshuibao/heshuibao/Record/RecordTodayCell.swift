//
//  RecordTodayCell.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/25.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class RecordTodayCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    var todayAddItem: TodayAddItem? {
        didSet {
            imgView?.image = UIImage(named: todayAddItem?.imgName ?? "itemWater")
            waterLabel.text = todayAddItem?.waterName
            timeLabel.text = todayAddItem?.time
            mlLabel.text = todayAddItem?.mlValue
            progressLabel.text = "当前进度： \(String(describing: todayAddItem!.progress))%"
        }
    }
    
    //
    private var imgView: UIImageView!
    private var waterLabel: UILabel!
    private var timeLabel: UILabel!
    private var mlLabel: UILabel!
    private var progressLabel: UILabel!
    
    //
    private func setup() {
        //
        let line = UIView()
        line.backgroundColor = COLOR_DETAILTEXTCOLOR
        line.alpha = 0.2
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(30.imgSize())
            make.right.equalTo(-30.imgSize())
            make.bottom.equalTo(self)
            make.height.equalTo(1.imgSize())
        }
        
        //
        imgView = UIImageView(image: UIImage(named: "itemWater"))
        imgView.contentMode = .scaleAspectFit
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp_left).offset(45.imgSize())
            make.centerY.equalTo(self).offset(8.imgSize())
            make.width.height.equalTo(20.imgSize())
        }
        
        //
        waterLabel = UILabel(title: "水", color: COLOR_MAINTEXTCOLOR, size: 18.imgSize())
        addSubview(waterLabel)
        waterLabel.snp.makeConstraints { (make) in
            make.left.equalTo(80.imgSize())
            make.top.equalTo(20.imgSize())
        }
        
        //
        timeLabel = UILabel(title: "19:35", color: COLOR_DETAILTEXTCOLOR, size: 13.imgSize())
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(waterLabel)
            make.top.equalTo(waterLabel.snp_bottom).offset(5.imgSize())
        }
        
        //
        mlLabel = UILabel(title: "150 ML", color: COLOR_MAINTEXTCOLOR, size: 18.imgSize())
        addSubview(mlLabel)
        mlLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-30.imgSize())
            make.centerY.equalTo(waterLabel)
        }
        
        //
        progressLabel = UILabel(title: "当前进度： 10%", color: COLOR_DETAILTEXTCOLOR, size: 13.imgSize())
        progressLabel.textAlignment = .right
        addSubview(progressLabel)
        progressLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeLabel)
            make.right.equalTo(mlLabel)
        }
    }

}
