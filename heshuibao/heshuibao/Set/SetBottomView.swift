//
//  SetBottomView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit
import MessageUI

protocol SetBottomViewDelegate: NSObject {
    func SetBottomViewDidClickPersonal()
    func SetBottomViewDidClickInfo()
}

class SetBottomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    private let titles = [["每日提醒", "个人资料", "喝水目标", "暗黑模式"], ["打卡分享", "给我评分", "意见反馈", "关于软件"]]
    private var details = [["", "头像、昵称等", "\(TodayViewModel.getTargetCount()) ML", "",], ["", "", "", "\(0.getVersionStr())"]]
    private let icons = [["setIcon0", "setIcon1", "setIcon2", "setIcon3"], ["setIcon4", "setIcon5", "setIcon6", "setIcon7"]]
    weak var delegate: SetBottomViewDelegate?
    private var tableview: UITableView!
    
    //
    private func setup() {
        
        tableview = UITableView(frame: CGRect.zero, style: .grouped)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(SetCell.self, forCellReuseIdentifier: "Set_Cell")
        tableview.backgroundColor = COLOR_BGCOLOR
        tableview.rowHeight = 65.IMGPX()
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.bottom.top.equalTo(self)
            make.left.equalTo(30.IMGPX())
            make.right.equalTo(-30.IMGPX())
        }
    }
}

extension SetBottomView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if #available(iOS 13.0, *) {
            return titles[section].count
        }else {
            return section==0 ? 3 : 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Set_Cell", for: indexPath) as! SetCell
        
        cell.iconName = icons[indexPath.section][indexPath.row]
        cell.titleName = titles[indexPath.section][indexPath.row]
        cell.detailName = details[indexPath.section][indexPath.row]
        
        cell.isSwitch = false
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                cell.isSwitch = true
                cell.myswitchBtn.isSelected = UserDefaults.standard.bool(forKey: REMINDER_STATUS_KEY)
            }
            if (indexPath.row==3) {
                cell.isSwitch = true
                cell.myswitchBtn.isSelected = UserDefaults.standard.bool(forKey: DAEK_MODE_KEY)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        let label = UILabel(title: section==0 ? "基础设置" : "更多设置", color: COLOR_DETAILTEXTCOLOR, size: 13.IMGPX())
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(view)
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0 && indexPath.section==0) {
            let cell = tableView.cellForRow(at: indexPath) as! SetCell
            cell.didSelctedCellIndex(index: 0)
        }
        
        if (indexPath.row == 3 && indexPath.section==0) {
            let cell = tableView.cellForRow(at: indexPath) as! SetCell
            cell.didSelctedCellIndex(index: 1)
        }
        
        if (indexPath.section==0 && indexPath.row==1) {
            // 个人资料
            delegate?.SetBottomViewDidClickPersonal()
        }
        if (indexPath.section==0 && indexPath.row==2) {
            
            // 喝水目标
            let targetview = SetTargetView()
            targetview.show()
            targetview.targetViewTap = { [weak self] in
                self?.updateData()
            }
        }
        if (indexPath.section==1 && indexPath.row==0) {
           let _ = SetShareView()
        }
        if (indexPath.section==1 && indexPath.row==1) {
            let url = "itms-apps://itunes.apple.com/cn/app/id\(MY_APP_ID)?mt=8&action=write-review"
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
        }
        if (indexPath.section==1 && indexPath.row==2) {
            print("意见反馈")
            WLHUD.shareHud().show()
            
            if MFMailComposeViewController.canSendMail() {
                let mailCompose = MFMailComposeViewController.init()
                mailCompose.mailComposeDelegate = self
                mailCompose.setSubject("喝水宝意见反馈：")
                mailCompose.setToRecipients(["w13071238644@gmail.com"])
                let eamilContent = ""
                mailCompose.setMessageBody(eamilContent, isHTML: false)
                UIApplication.shared.keyWindow?.rootViewController?.present(mailCompose, animated: true, completion: {
                    WLHUD.shareHud().removeAnimate()
                })
            }else {
                //
                let url = "http://m130712386441.lofter.com/post/1d620664_1c76b6500"
                UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
                WLHUD.shareHud().removeAnimate()
                
            }
        }
        if (indexPath.section==1 && indexPath.row==3) {
            delegate?.SetBottomViewDidClickInfo()
        }
    }
    
    private func updateData() {
        details = [["", "头像、昵称等", "\(TodayViewModel.getTargetCount()) ML", ""], ["", "", "", "v1.0"]]
        tableview.reloadData()
    }
    
    public func checkStatus() {
    tableview.reloadData()
    }
}

extension SetBottomView: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
