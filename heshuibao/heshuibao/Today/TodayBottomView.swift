//
//  TodayBottomView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/22.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit
import KDCircularProgress

class TodayBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var progress: KDCircularProgress!
    private var proLabel: UILabel!
    private var targetLabel: UILabel!
    private var finishiLabel: UILabel!
    
    private func setup() {
        // 1. 左边进度条
        progress = KDCircularProgress()
        progress.startAngle = -90
        
        progress.progressThickness = 0.2
        progress.trackThickness = 0.2
        progress.clockwise = true
        progress.glowMode = .noGlow
        
        progress.set(colors: UIColor(r: 109, g: 170, b: 248))
        progress.trackColor = UIColor(r: 237, g: 237, b: 237)
        addSubview(progress)
        progress.snp.makeConstraints { (make) in
            make.left.equalTo(40.IMGPX())
            make.centerY.equalTo(self)
            make.width.height.equalTo(100.IMGPX())
        }
        
        // 0- 360 0-100
        let progressValue = TodayViewModel.getProgress()
        progress.angle = Double(progressValue>100 ? 100 : progressValue)*3.6
        
        // 2. 进度文字
        proLabel = UILabel(title: "\(TodayViewModel.getProgress()) %", color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX(), weight: .bold)
        progress.addSubview(proLabel)
        proLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(progress)
            make.centerX.equalTo(progress.snp.centerX).offset(3.IMGPX())
        }
        
        // 3. 右边的文字
        let targetStr = NSString(format: "%.2f L", CGFloat(TodayViewModel.getTargetCount()) / 1000.0) as String
        targetLabel = setupRightText(centerYOffX: -20.IMGPX(), imgName: "targetDot", leftName: "今日目标：", rightName: targetStr)
        
        let todayStr = NSString(format: "%.2f L", CGFloat(TodayViewModel.getTodayCount()) / 1000.0) as String
        finishiLabel = setupRightText(centerYOffX: 20.IMGPX(), imgName: "finishiDot", leftName: "今日完成：", rightName: todayStr)
    }
    
    private func setupRightText(centerYOffX: CGFloat, imgName: String, leftName: String, rightName: String) -> UILabel {
        
        let leftImg = UIImageView(image: UIImage(named: imgName))
        addSubview(leftImg)
        leftImg.snp.makeConstraints { (make) in
            make.left.equalTo(190.IMGPX())
            make.centerY.equalTo(self).offset(centerYOffX)
            make.width.height.equalTo(18.IMGPX())
        }
        
        let leftLabel = UILabel(title: leftName, color: COLOR_DETAILTEXTCOLOR, size: 18.IMGPX())
        addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftImg)
            make.left.equalTo(leftImg.snp_right).offset(10.IMGPX())
        }
        
        let rightLabel = UILabel(title: rightName, color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX(), weight: .thin)
        addSubview(rightLabel)
        rightLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftImg)
            make.right.equalTo(-35.IMGPX())
        }
        
        return rightLabel
    }
    
    func updateData() {
        finishiLabel.text = NSString(format: "%.2f L", CGFloat(TodayViewModel.getTodayCount()) / 1000.0) as String
        proLabel.text = "\(TodayViewModel.getProgress()) %"
        let progressValue = TodayViewModel.getProgress()
        progress.animate(toAngle: Double(progressValue>100 ? 100 : progressValue)*3.6, duration: 1, completion: nil)
    }

}
