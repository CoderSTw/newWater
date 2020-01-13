//
//  ReocrdAllCell.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class ReocrdAllCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var item: RecordItrem? {
        didSet {
            let fmt = DateFormatter()
            fmt.dateFormat = "MM / dd"
            waterLabel.text = fmt.string(from: item!.date!)
            progressLabel.text = "完成进度：\(item!.progress)%"
            mlLabel.text = "\(item!.mlVlalue) ML"
            if item?.progress ?? 0>=Int64(100) {
                finishiView.finishStatus = .Done
            }else {
                finishiView.finishStatus = .Fail
            }
        }
    }
    
    //
    private var imgView: UIImageView!
    private var waterLabel: UILabel!
    private var progressLabel: UILabel!
    private var mlLabel: UILabel!
    private var finishiView: WeekFinishView!
    
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
        waterLabel = UILabel(title: "所有饮品", color: COLOR_MAINTEXTCOLOR, size: 18.imgSize())
        addSubview(waterLabel)
        waterLabel.snp.makeConstraints { (make) in
            make.left.equalTo(80.imgSize())
            make.top.equalTo(20.imgSize())
        }
        
        //
        progressLabel = UILabel(title: "完成进度： 100%", color: COLOR_DETAILTEXTCOLOR, size: 13.imgSize())
        addSubview(progressLabel)
        progressLabel.snp.makeConstraints { (make) in
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
        finishiView = WeekFinishView()
        finishiView.finishStatus = .Done
        addSubview(finishiView)
        finishiView.snp.makeConstraints { (make) in
            make.centerY.equalTo(progressLabel)
            make.right.equalTo(mlLabel)
            make.width.equalTo(40.imgSize())
            make.height.equalTo(16.imgSize())
        }
    }

}
