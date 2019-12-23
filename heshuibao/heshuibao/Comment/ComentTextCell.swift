//
//  ComentTextCell.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/22.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class ComentTextCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected == true) {
                checkImg.isHidden = false
            }else {
                checkImg.isHidden = true
            }
        }
    }
    
    private var checkImg: UIImageView!
    private var label: UILabel!
    
    var titleName: String? {
        didSet {
            label.text = titleName ?? ""
        }
    }
    
    private func setup() {
        
        selectionStyle = .none
        
        label = UILabel(title: "你好啊", color: COLOR_MAINTEXTCOLOR, size: 18.imgSize())
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = COLOR_DETAILTEXTCOLOR
        bottomLine.alpha = 0.2
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1.imgSize())
        }
        
        checkImg = UIImageView(image: UIImage(named: "check"))
        checkImg.isHidden = true
        addSubview(checkImg)
        checkImg.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self)
            make.width.equalTo(14.imgSize())
            make.height.equalTo(11.imgSize())
        }
    }

}

