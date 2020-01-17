//
//  SetWeightView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/16.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit

class SetWeightView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var weightviewOKBlock: (()->())?
    
    private func setup() {
        let commentview = SetCommentView()
        commentview.commentviewOKBlock = {
            // 通知更换
            self.weightviewOKBlock?()
        }
        let weightview = BeginSecondView()
        commentview.bottomView.addSubview(weightview)
        weightview.snp.makeConstraints { (make) in
            make.center.width.equalTo(commentview.bottomView)
            make.height.equalTo(280.IMGPX())
        }
        commentview.show(name: "请选择您的体重")
    }
}
