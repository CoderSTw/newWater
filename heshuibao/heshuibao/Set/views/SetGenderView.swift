//
//  SetGenderView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/16.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit

class SetGenderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var genderviewOKBlock: (()->())?
    
    private func setup() {
        let commentview = SetCommentView()
        commentview.commentviewOKBlock = {
            // 通知更换
            self.genderviewOKBlock?()
        }
        let genderview = BeginZeroView()
        commentview.bottomView.addSubview(genderview)
        genderview.snp.makeConstraints { (make) in
            make.width.equalTo(375.IMGPX())
            make.top.equalTo(-30.IMGPX())
            make.centerX.equalTo(commentview.bottomView)
            make.height.equalTo(280.IMGPX())
        }
        commentview.show(name: "请选择您的性别")
    }

}
