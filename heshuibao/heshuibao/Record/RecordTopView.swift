//
//  RecordTopView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/25.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

protocol RecordTopViewDelegate: NSObject {
    func RecordTopViewDidClickBtn(index: Int)
}

class RecordTopView: UIView {
    
    init(titles: Array<String>) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 79.IMGPX() + NEW_AREA*1.5))
        
        setup(titles: titles)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private var line: UIView!
    weak var delegate: RecordTopViewDelegate?
    
    //
    private func setup(titles: Array<String>) {
        
        backgroundColor = COLORT_MAIN_BLUE
        
        for i in 0..<3 {
            let btn = UIButton()
            btn.tag = i+1618
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.left.equalTo(CGFloat(i) * SCREEN_WIDTH/3)
                make.bottom.equalTo(self)
                make.height.equalTo(50.IMGPX())
                make.width.equalTo(SCREEN_WIDTH/3)
            }
            
            let label = UILabel(title: titles[i], color: .white, size: 18.IMGPX())
            btn.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.centerX.equalTo(btn)
                make.bottom.equalTo(-20.IMGPX())
            }
            
            if (i==0) {
                line = UIView()
                line.backgroundColor = .white
                line.cornerRadius(radius: 1.IMGPX())
                btn.addSubview(line)
                line.snp.makeConstraints { (make) in
                    make.centerX.equalTo(btn)
                    make.bottom.equalTo(-5.IMGPX())
                    make.width.equalTo(24.IMGPX())
                    make.height.equalTo(2.IMGPX())
                }
            }
        }
    }
    
    func setOffX(index: Int) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
            self.line.transform = CGAffineTransform.init(translationX: CGFloat(index) * SCREEN_WIDTH/3, y: 0)
        }) { (_) in }
    }
    
    @objc func btnClick(btn: UIButton) {
        let index = btn.tag - 1618
        
        delegate?.RecordTopViewDidClickBtn(index: index)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
            self.line.transform = CGAffineTransform.init(translationX: CGFloat(index) * SCREEN_WIDTH/3, y: 0)
        }) { (_) in }
    }

}
