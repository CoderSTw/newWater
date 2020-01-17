//
//  SetInfoViewController.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/16.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit
import MessageUI

class SetInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = COLOR_BGCOLOR

        setup()
    }
    
    private func setup() {
        // top
        let topview = UIView(frame: .init(x: 0, y: 0, width: SCREEN_WIDTH, height: 79.IMGPX() + NEW_AREA*1.5))
        topview.backgroundColor = COLORT_MAIN_BLUE
        view.addSubview(topview)
        
        let toplabel = UILabel(title: "关于软件", color: .white, size: 18.IMGPX(), weight: .medium)
        topview.addSubview(toplabel)
        toplabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(topview)
            make.bottom.equalTo(-17.IMGPX() - NEW_AREA*0.5)
        }
        
        let backbtn = UIButton()
        backbtn.setImage(UIImage(named: "back"), for: .normal)
        backbtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        topview.addSubview(backbtn)
        backbtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(toplabel)
            make.left.equalTo(35.IMGPX())
            make.width.equalTo(23.IMGPX())
            make.height.equalTo(17.IMGPX())
        }
        
        let iconImg = UIImageView(image: UIImage(named: "seticon"))
        view.addSubview(iconImg)
        iconImg.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(topview.snp_bottom).offset(50.IMGPX())
            make.width.height.equalTo(158.IMGPX())
        }
        
        let namelabel = UILabel(title: "喝水宝", color: COLORT_MAIN_BLUE, size: 20.IMGPX(), weight: .medium)
        view.addSubview(namelabel)
        namelabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(iconImg.snp_bottom).offset(20.IMGPX())
        }
        
        let verlabel = UILabel(title: "\(0.getVersionStr())", color: COLOR_DETAILTEXTCOLOR, size: 15.IMGPX())
        view.addSubview(verlabel)
        verlabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(namelabel.snp_bottom).offset(10.IMGPX())
        }
        
        let feedbtn = UIButton()
        feedbtn.setTitle("意见反馈", for: .normal)
        feedbtn.setTitleColor(COLORT_MAIN_BLUE, for: .normal)
        feedbtn.addTarget(self, action: #selector(feebClick), for: .touchUpInside)
        view.addSubview(feedbtn)
        feedbtn.snp.makeConstraints { (make) in
            make.right.equalTo(view.snp_centerX).offset(-20.IMGPX())
            make.bottom.equalTo(-20.IMGPX()-NEW_AREA)
            make.width.equalTo(80.IMGPX())
            make.height.equalTo(30.IMGPX())
        }
        
        let line = UIView()
        line.backgroundColor = COLOR_DETAILTEXTCOLOR
        view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.width.equalTo(1.IMGPX())
            make.centerY.equalTo(feedbtn)
            make.height.equalTo(15.IMGPX())
        }
        
        let ratebtn = UIButton()
        ratebtn.setTitle("给我评分", for: .normal)
        ratebtn.setTitleColor(COLORT_MAIN_BLUE, for: .normal)
        ratebtn.addTarget(self, action: #selector(rateClick), for: .touchUpInside)
        view.addSubview(ratebtn)
        ratebtn.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp_centerX).offset(20.IMGPX())
            make.bottom.equalTo(-20.IMGPX()-NEW_AREA)
            make.width.equalTo(80.IMGPX())
            make.height.equalTo(30.IMGPX())
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    @objc func backBtnClick() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func feebClick() {
        WLHUD.shareHud().show()
        
        if MFMailComposeViewController.canSendMail() {
            let mailCompose = MFMailComposeViewController.init()
            mailCompose.mailComposeDelegate = self
            mailCompose.setSubject("喝水宝意见反馈：")
            mailCompose.setToRecipients(["w13071238644@gmail.com"])
            let eamilContent = ""
            mailCompose.setMessageBody(eamilContent, isHTML: false)
            self.present(mailCompose, animated: true, completion: {
                WLHUD.shareHud().removeAnimate()
            })
        }else {
            //
            let url = "http://m130712386441.lofter.com/post/1d620664_1c76b6500"
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
            WLHUD.shareHud().removeAnimate()
            
        }
    }
    
    @objc func rateClick() {
        let url = "itms-apps://itunes.apple.com/cn/app/id\(MY_APP_ID)?mt=8&action=write-review"
        UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
    }
}

extension SetInfoViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
