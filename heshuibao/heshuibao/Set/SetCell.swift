//
//  SetCell.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class SetCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    var iconName: String? {
        didSet {
            leftIcon.image = UIImage(named: iconName ?? "setIcon0")
        }
    }
    var titleName: String? {
        didSet {
            titleLabel.text = titleName ?? ""
        }
    }
    var detailName: String? {
        didSet {
            detailLabel.text = detailName ?? ""
        }
    }
    var isSwitch: Bool? {
        didSet {
            if (isSwitch==true) {
                rightCheck.isHidden = true
                myswitchBtn.isHidden = false
            }else {
                rightCheck.isHidden = false
                myswitchBtn.isHidden = true
            }
        }
    }
    
    //
    private var leftIcon: UIImageView!
    private var titleLabel: UILabel!
    private var rightCheck: UIImageView!
    private var detailLabel: UILabel!
    var myswitchBtn: UIButton!
    
    //
    private func setup() {
        //
        let line = UIView()
        line.backgroundColor = UIColor(r: 151, g: 151, b: 151)
        line.alpha = 0.1
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1.imgSize())
        }
        
        //
        leftIcon = UIImageView(image: UIImage(named: "setIcon0"))
        leftIcon.contentMode = .scaleAspectFit
        addSubview(leftIcon)
        leftIcon.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
            make.width.height.equalTo(23.imgSize())
        }
        
        //
        titleLabel = UILabel(title: "111", color: COLOR_MAINTEXTCOLOR, size: 18.imgSize())
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(40.imgSize())
        }
        
        //
        rightCheck = UIImageView(image: UIImage(named: "setcheck"))
        addSubview(rightCheck)
        rightCheck.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self)
            make.width.equalTo(8.imgSize())
            make.height.equalTo(11.imgSize())
        }
        
        //
        detailLabel = UILabel(title: "", color: COLOR_DETAILTEXTCOLOR, size: 13.imgSize())
        detailLabel.alpha = 0.6
        detailLabel.textAlignment = .right
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(-30.imgSize())
        }
        
        //
        myswitchBtn = UIButton()
        myswitchBtn.setBackgroundImage(UIImage(named: "timeBtn"), for: .normal)
        myswitchBtn.setBackgroundImage(UIImage(named: "timeBtnSel"), for: .selected)
        myswitchBtn.isUserInteractionEnabled = false
        myswitchBtn.isHidden = true
        addSubview(myswitchBtn)
        myswitchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(0.imgSize())
            make.centerY.equalTo(self)
            make.width.equalTo(40.imgSize())
            make.height.equalTo(25.imgSize())
        }
    }
    
    func didSelctedCellIndex(index: Int) {
        if (index==0) {
            myswitchBtn.isSelected = !UserDefaults.standard.bool(forKey: REMINDER_STATUS_KEY)
            UserDefaults.standard.set(myswitchBtn.isSelected, forKey: REMINDER_STATUS_KEY)
        }else {
            myswitchBtn.isSelected = !UserDefaults.standard.bool(forKey: DAEK_MODE_KEY)
            UserDefaults.standard.set(myswitchBtn.isSelected, forKey: DAEK_MODE_KEY)
        }
    }
}
