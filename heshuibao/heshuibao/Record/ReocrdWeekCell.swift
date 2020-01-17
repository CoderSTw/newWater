//
//  ReocrdWeekCell.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/25.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class ReocrdWeekCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = COLOR_BGCOLOR
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private var dotImg: UIImageView!
    var timeLabel: UILabel!
    private var mlLabel: UILabel!
    private var finishiView: WeekFinishView!
    
    //
    var item: RecordSnpItem? {
        didSet {
            if item==nil {
                return
            }else {
                let fmt = DateFormatter()
                fmt.dateFormat = "  MM / dd"
                let str = timeLabel.text!
                timeLabel.text = str + fmt.string(from: item!.date!)
                mlLabel.text = "\(item!.mlVlalue!) ML"
                if (item!.progress == -1) {
                    finishiView.finishStatus = .None
                    dotImg.image = UIImage(named: "noneDot")
                }else {
                    if item!.progress!>=100 {
                        finishiView.finishStatus = .Done
                        dotImg.image = UIImage(named: "doneDot")
                    }else {
                        finishiView.finishStatus = .Fail
                        dotImg.image = UIImage(named: "failDot")
                    }
                }
            }
        }
    }
    
    //
    private func setup() {
        dotImg = UIImageView(image: UIImage(named: "doneDot"))
        addSubview(dotImg)
        dotImg.snp.makeConstraints { (make) in
            make.left.equalTo(25.IMGPX())
            make.top.equalTo(self)
            make.width.height.equalTo(18.IMGPX())
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(r: 244, g: 247, b: 250)
        addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.centerX.equalTo(dotImg)
            make.top.equalTo(dotImg.snp_bottom)
            make.width.equalTo(1.IMGPX())
            make.height.equalTo(50.IMGPX())
        }
        
        timeLabel = UILabel(title: "星期一  12 / 10", color: COLOR_DETAILTEXTCOLOR, size: 13.IMGPX())
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dotImg.snp_right).offset(15.IMGPX())
            make.centerY.equalTo(dotImg)
        }
        
        mlLabel = UILabel(title: "2.25 L", color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX())
        addSubview(mlLabel)
        mlLabel.snp.makeConstraints { (make) in
            make.left.equalTo(timeLabel)
            make.top.equalTo(timeLabel.snp_bottom).offset(10.IMGPX())
        }
        
        finishiView = WeekFinishView()
        finishiView.finishStatus = .Done
        addSubview(finishiView)
        finishiView.snp.makeConstraints { (make) in
            make.centerY.equalTo(mlLabel)
            make.right.equalTo(-25.IMGPX())
            make.width.equalTo(40.IMGPX())
            make.height.equalTo(16.IMGPX())
        }
    }
}

enum WeekFinishStatus {
    case Done, Fail, None
}

class WeekFinishView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    var finishStatus: WeekFinishStatus? {
        didSet {
            if (finishStatus == .Done) {
                img.image = UIImage(named: "done")
                label.text = "完成"
                label.textColor = UIColor(r: 97, g: 195, b: 136)
            }else if (finishStatus == .Fail) {
                img.image = UIImage(named: "fail")
                label.text = "失败"
                label.textColor = UIColor(r: 255, g: 138, b: 100)
            }else {
                img.image = UIImage(named: "none")
                label.text = "暂无"
                label.textColor = UIColor(r: 151, g: 174, b: 205)
            }
        }
    }
    //
    private var img: UIImageView!
    private var label: UILabel!
    
    //
    private func setup() {
        img = UIImageView()
        addSubview(img)
        img.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(40.IMGPX())
            make.height.equalTo(16.IMGPX())
        }
        
        label = UILabel(title: "完成", color: .green, size: 10.IMGPX())
        img.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalTo(img)
        }
    }
}
