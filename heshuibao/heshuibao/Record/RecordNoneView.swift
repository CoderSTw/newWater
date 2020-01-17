//
//  RecordNoneView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/14.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit

class RecordNoneView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var label: UILabel!
    var name: String? {
        didSet {
            label.text = name
        }
    }
    
    private func setup() {
        let imgview = UIImageView(image: UIImage(named: "noneview"))
        imgview.contentMode = .scaleAspectFit
        addSubview(imgview)
        imgview.snp.makeConstraints { (make) in
            make.top.centerX.equalTo(self)
            make.width.height.equalTo(150.IMGPX())
        }
        
        label = UILabel(title: "", color: COLOR_DETAILTEXTCOLOR, size: 14.IMGPX())
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgview)
            make.top.equalTo(imgview.snp_bottom).offset(20.IMGPX())
        }
    }

}
