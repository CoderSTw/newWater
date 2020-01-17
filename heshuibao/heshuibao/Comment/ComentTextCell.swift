//
//  ComentTextCell.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/22.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class ComentTextCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = COLOR_BGCOLOR
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                checkImg.isHidden = false
            }else {
                checkImg.isHidden = true
            }
        }
    }
    
    var imgName: String = "" {
        didSet {
            // 新建图片
            let imgView = UIImageView(image: UIImage(named: imgName))
            imgView.contentMode = .scaleAspectFit
            addSubview(imgView)
            imgView.snp.makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.left.equalTo(0)
                make.width.height.equalTo(16.IMGPX())
            }
            
            // 更改label位置
            label.snp.updateConstraints { (make) in
                make.left.equalTo(50.IMGPX())
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
        
        label = UILabel(title: "你好啊", color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX())
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
            make.height.equalTo(1.IMGPX())
        }
        
        checkImg = UIImageView(image: UIImage(named: "check"))
        checkImg.isHidden = true
        addSubview(checkImg)
        checkImg.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self)
            make.width.equalTo(14.IMGPX())
            make.height.equalTo(11.IMGPX())
        }
    }

}

