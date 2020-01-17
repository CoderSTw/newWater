//
//  SetShareView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/17.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit

class SetShareView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var view: UIView!
    var shareViewBlock: ((_ image: UIImage)->())?
    
    private func setup() {
        let commentview = SetCommentView()
        commentview.titleName = "分享"
        commentview.commentviewOKBlock = {
            // 截图分享
            WLHUD.shareHud().show()
            let image = self.view.asImage()
            let items = [image] as [Any]
            let activityVC = UIActivityViewController(
                 activityItems: items,
                 applicationActivities: nil)
            
            activityVC.completionWithItemsHandler =  { activity, success, items, error in
                
                if success {
                    WLHUD.shareHud().showWithSuccess(name: "分享成功！", Dismiss: {})
                }
                 
            }
            UIApplication.shared.keyWindow?.rootViewController?.present(activityVC, animated: true, completion: {
                WLHUD.shareHud().removeAnimate()
            })
        }
        commentview.commentviewTapBlock = {
            UIView.animate(withDuration: 0.5, animations: {
                commentview.alpha = 0
            }) { (_) in
                commentview.removeFromSuperview()
            }
        }
        commentview.show(name: "今日喝水情况分享：")
        
        view = UIView()
        view.backgroundColor = COLOR_BGCOLOR
        commentview.bottomView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.right.equalTo(commentview.bottomView)
            make.top.equalTo(50.IMGPX())
            make.bottom.equalTo(-80.IMGPX())
        }
        
        //
        let iconImg = UIImageView(image: UIImage(named: "seticon"))
        view.addSubview(iconImg)
        iconImg.snp.makeConstraints { (make) in
            make.left.equalTo(25.IMGPX())
            make.top.equalTo(50.IMGPX())
            make.width.height.equalTo(75.IMGPX())
        }
        
        let mlLabel = UILabel()
        mlLabel.text = "\(TodayViewModel.getTodayCount())"
        mlLabel.textColor = COLORT_MAIN_BLUE
        mlLabel.font = UIFont(name: "Avenir-MediumOblique", size: 60.IMGPX())
        mlLabel.textAlignment = .center
        view.addSubview(mlLabel)
        mlLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImg)
            make.left.equalTo(iconImg.snp_right).offset(45.IMGPX())
            make.width.equalTo(200.IMGPX())
        }
        
        //
        let detailLabel = UILabel(title: "ML", color: COLORT_MAIN_BLUE, size: 15.IMGPX(), weight: .medium)
        detailLabel.alpha = 0.7
        view.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-40.IMGPX())
            make.bottom.equalTo(mlLabel.snp_bottom).offset(-10.IMGPX())
        }
        
        let line = UIView()
        line.backgroundColor = COLOR_DETAILTEXTCOLOR
        line.alpha = 0.3
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(25.IMGPX())
            make.right.equalTo(-25.IMGPX())
            make.top.equalTo(iconImg.snp_bottom).offset(30.IMGPX())
            make.height.equalTo(1.IMGPX())
        }
        
        let touxiangimg = UIImageView(image: UIImage(named: "icon"))
        let path = NSHomeDirectory()
        let imagePath = path + "/Documents/icon.png"
        let image = UIImage(contentsOfFile: imagePath)
        if (image != nil) {
            touxiangimg.image = image
        }
        touxiangimg.cornerRadius(radius: 28.IMGPX())
        view.addSubview(touxiangimg)
        touxiangimg.snp.makeConstraints { (make) in
            make.left.equalTo(25.IMGPX())
            make.top.equalTo(line.snp_bottom).offset(30.IMGPX())
            make.width.height.equalTo(56.IMGPX())
        }
        
        let fmt = DateFormatter()
        fmt.dateFormat = "M"
        let monthstr = fmt.string(from: Date())
        fmt.dateFormat = "d"
        let datstr = fmt.string(from: Date())
        let riqiLabel = UILabel(title: "\(monthstr) 月 \(datstr) 日", color: COLORT_MAIN_BLUE, size: 18.IMGPX(), weight: .medium)
        view.addSubview(riqiLabel)
        riqiLabel.snp.makeConstraints { (make) in
            make.left.equalTo(touxiangimg.snp_right).offset(40.IMGPX())
            make.top.equalTo(touxiangimg).offset(5.IMGPX())
        }
        
        let nameLabel = UILabel(title: "\(UserDefaults.standard.string(forKey: NEAL_NAME_KEY)!)", color: COLOR_DETAILTEXTCOLOR, size: 13.IMGPX())
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(riqiLabel)
            make.top.equalTo(riqiLabel.snp_bottom).offset(10.IMGPX())
        }
    }

}
