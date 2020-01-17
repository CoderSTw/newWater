//
//  BeginIndicatorView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class BeginIndicatorView: UIView {
    
    //
    var dotViews: Array<UIView> = Array()

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 32.IMGPX()
            + NEW_AREA*2, width: SCREEN_WIDTH, height: 5.IMGPX()))
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        let count = 2.5.IMGPX() + 9.IMGPX()
        let offXs = [-2, -1, 0, 0, 1, 2]
        for i in 0..<6 {
            let dotView = UIView()
            dotView.cornerRadius(radius: 3.IMGPX())
            addSubview(dotView)
  
            dotView.snp.makeConstraints { (make) in
                if i<3 {
                    make.right.equalTo(self.snp.centerX).offset(-2.5.IMGPX() + CGFloat(offXs[i])*count)
                }else {
                    make.left.equalTo(self.snp.centerX).offset(2.5.IMGPX() + CGFloat(offXs[i])*count)
                }
                make.top.height.equalTo(self)
                make.width.equalTo(9.IMGPX())
            }
            dotViews.append(dotView)
        }
    }
    
    func setPageNum(num: Int) {
        for dotView in dotViews {
            dotView.backgroundColor = UIColor(r: 240, g: 242, b: 246)
        }
        let currentView = dotViews[num]
        currentView.backgroundColor = UIColor(named: "DarkBlue")
    }

}
