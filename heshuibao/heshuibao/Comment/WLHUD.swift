//
//  WLHUD.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/14.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit

class WLHUD: UIView {
    
    // MARK: - 创建单利
    static let instences_hud: WLHUD = WLHUD()
    class func shareHud() -> WLHUD {
        return instences_hud
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var leftImg: UIImageView!
    private var titlelabel: UILabel!
    private var blackView: UIView!
    private var topview: UIView!
    private var ac: UIActivityIndicatorView!
    
    private func setup() {
        
        //
        blackView = UIView()
        blackView.backgroundColor = .black
        blackView.alpha = 0.2
        addSubview(blackView)
        blackView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        //
        topview = UIView()
        topview.backgroundColor = COLOR_BGCOLOR
        topview.cornerRadius(radius: 28.IMGPX())
        addSubview(topview)
        topview.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(25.IMGPX() + NEW_AREA)
            make.width.equalTo(217.IMGPX())
            make.height.equalTo(56.IMGPX())
        }
        
        //
        leftImg = UIImageView()
        topview.addSubview(leftImg!)
        leftImg!.snp.makeConstraints { (make) in
            make.centerY.equalTo(topview)
            make.left.equalTo(15.IMGPX())
            make.width.height.equalTo(18.IMGPX())
        }
        
        //
        titlelabel = UILabel(title: "", color: COLOR_MAINTEXTCOLOR, size: 14.IMGPX(), weight: .medium)
        topview.addSubview(titlelabel)
        titlelabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(topview)
            make.centerX.equalTo(topview.snp_centerX).offset(10.IMGPX())
        }
        
        ac = UIActivityIndicatorView()
        ac.style = .gray
        topview.addSubview(ac)
        ac.startAnimating()
        ac.snp.makeConstraints { (make) in
            make.centerY.equalTo(topview)
            make.left.equalTo(15.IMGPX())
            make.width.height.equalTo(topview.snp_height)
        }
    }
    
    func showWithSuccess(name: String, Dismiss: @escaping(()->())) {
        leftImg.image = UIImage(named: "success")
        titlelabel.text = name
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(UIApplication.shared.keyWindow?.rootViewController?.view ?? self)
        }
        
        animate()
        leftImg.alpha = 1
        ac.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.removeAnimate()
            Dismiss()
        }
    }
    
    func showWithError(name: String) {
        leftImg.image = UIImage(named: "error")
        titlelabel.text = name
    UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(UIApplication.shared.keyWindow?.rootViewController?.view ?? self)
        }
        
        leftImg.alpha = 1
        ac.alpha = 0
        animate()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.removeAnimate()
        }
    }
    
    func show() {
        
        titlelabel.text = "正在加载..."
        leftImg.alpha = 0
        ac.alpha = 1
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(self)
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(UIApplication.shared.keyWindow?.rootViewController?.view ?? self)
        }
        
        animate()
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.4, animations: {
            self.blackView.alpha = 0
            self.topview.transform = CGAffineTransform.init(translationX: 0, y: -200.IMGPX())
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    private func animate() {
        blackView.alpha = 0
        topview.transform = CGAffineTransform.init(translationX: 0, y: -200.IMGPX())
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.9, options: .curveLinear, animations: {
            self.blackView.alpha = 0.2
            self.topview.transform = .identity
        }) { (_) in
            
        }
    }
}
