//
//  SetTopView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class SetTopView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var iconImg: UIImageView!
    private var nameLabel: UILabel!
    private var mlLabel: UILabel!
    var topviewClickImg: (()->())?
    
    private func setup() {
        //
        backgroundColor = COLORT_MAIN_BLUE
        
        //
        let bgShadowView = UIImageView(image: UIImage(named: "setshadow"))
        addSubview(bgShadowView)
        bgShadowView.snp.makeConstraints { (make) in
            make.left.equalTo(0.IMGPX())
            make.top.equalTo(24.IMGPX() + NEW_AREA*1)
            make.width.equalTo(160.IMGPX())
            make.height.equalTo(160.IMGPX())
        }
        
        //
        iconImg = UIImageView(image: UIImage(named: "icon"))
        let path = NSHomeDirectory()
        let imagePath = path + "/Documents/icon.png"
        let image = UIImage(contentsOfFile: imagePath)
        if (image != nil) {
            iconImg.image = image
        }
        iconImg.cornerRadius(radius: 18.IMGPX())
        iconImg.isUserInteractionEnabled = true
        iconImg.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(iconImgClick)))
        addSubview(iconImg)
        iconImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(bgShadowView)
            make.centerY.equalTo(bgShadowView)
            make.width.height.equalTo(114.IMGPX())
        }
        
        nameLabel = UILabel(title: "\(UserDefaults.standard.string(forKey: NEAL_NAME_KEY)!)", color: .white, size: 18.IMGPX(), weight: .medium)
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(iconImg.snp_right).offset(140.IMGPX())
            make.top.equalTo(iconImg).offset(10.IMGPX())
        }
        
        //
        mlLabel = UILabel()
        mlLabel.text = "\(TodayViewModel.getTodayCount())"
        mlLabel.textColor = .white
        mlLabel.font = UIFont(name: "Avenir-MediumOblique", size: 60.IMGPX())
        mlLabel.textAlignment = .center
        addSubview(mlLabel)
        mlLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp_bottom)
            make.width.equalTo(200.IMGPX())
        }
        
        //
        let detailLabel = UILabel(title: "ML", color: .white, size: 15.IMGPX(), weight: .medium)
        detailLabel.alpha = 0.7
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-40.IMGPX())
            make.bottom.equalTo(-5.IMGPX())
        }
    }
    
    public func loadImg() {
        iconImg.image = UIImage(named: "icon")
        let path = NSHomeDirectory()
        let imagePath = path + "/Documents/icon.png"
        let image = UIImage(contentsOfFile: imagePath)
        if (image != nil) {
            iconImg.image = image
        }
        nameLabel.text = "\(UserDefaults.standard.string(forKey: NEAL_NAME_KEY)!)"
        mlLabel.text = "\(TodayViewModel.getTodayCount())"
    }
    
    @objc func iconImgClick() {
        topviewClickImg?()
    }

}
