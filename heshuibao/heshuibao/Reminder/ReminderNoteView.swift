//
//  ReminderNoteView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/26.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class ReminderNoteView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    // MARK: - shuxing
    private var blackView: UIView?
    private var textField: UITextField!
    private var notes = UserDefaults.standard.object(forKey: NOTE_ARR_KEY) as! [String]
    private var selRow = UserDefaults.standard.integer(forKey: NOTE_SEL_ROW_KEY)
    private var tableView: UITableView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
//        addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(tap)))
        
        //
        let titleLabel = UILabel(title: "新增提醒文字：", color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX())
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30.IMGPX())
            make.top.equalTo(35.IMGPX())
        }
        
        //
        textField = UITextField()
        textField.placeholder = "请输入提醒文字..."
        textField.delegate = self
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(40.IMGPX())
            make.right.equalTo(-35.IMGPX())
            make.top.equalTo(titleLabel.snp_bottom).offset(20.IMGPX())
            make.height.equalTo(44.IMGPX())
        }
        
        //
        let line = UIView()
        line.backgroundColor = COLOR_DETAILTEXTCOLOR
        line.alpha = 0.2
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(30.IMGPX())
            make.right.equalTo(-30.IMGPX())
            make.top.equalTo(textField.snp_bottom)
            make.height.equalTo(1.IMGPX())
        }
        
        //
        let addBtn = UIButton()
        addBtn.setBackgroundImage(UIImage(named: "nextBtn"), for: .normal)
        addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
        addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(line.snp_bottom).offset(45.IMGPX())
            make.width.equalTo(158.IMGPX())
            make.height.equalTo(40.IMGPX())
        }
        
        let addLabel = UILabel(title: "添加", color: .white, size: 15.IMGPX(), weight: .medium)
        addSubview(addLabel)
        addLabel.snp.makeConstraints { (make) in
            make.center.equalTo(addBtn)
        }
        
        //
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ComentTextCell.self, forCellReuseIdentifier: "Reminder_Note_Cell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 65.IMGPX()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = COLOR_BGCOLOR
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.equalTo(30.IMGPX())
            make.right.equalTo(-30.IMGPX())
            make.bottom.equalTo(self)
            make.top.equalTo(addBtn.snp_bottom).offset(45.IMGPX())
        }
    }

}

// MARK: - tableview
extension ReminderNoteView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Reminder_Note_Cell") as! ComentTextCell
        
        cell.titleName = notes[indexPath.row]
        cell.imgName = "remindernote"
        
        if indexPath.row==selRow {
            cell.isChecked = true
        }else {
            cell.isChecked = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        FullMannager.shareManager().loadFull(vc: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {
            DispatchQueue.main.async {
                let oldcell = tableView.cellForRow(at: IndexPath(row: self.selRow, section: 0)) as? ComentTextCell ?? ComentTextCell()
                oldcell.isChecked = false
                
                let cell = tableView.cellForRow(at: indexPath) as! ComentTextCell
                cell.isChecked = true
                self.selRow = indexPath.row
                UserDefaults.standard.set(self.selRow, forKey: NOTE_SEL_ROW_KEY)
                UserDefaults.standard.synchronize()
                
                ReminderManager.shareManager().addReminder()
            }
        }
    }
    
    @objc func addBtnClick() {
        if textField.text=="" {
            
            WLHUD.shareHud().showWithError(name: "请输入文字！")
            
            return
        }
        
        WLHUD.shareHud().showWithSuccess(name: "新增成功！", Dismiss: {
            FullMannager.shareManager().loadFull(vc: UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()) {
            }
        })
        notes.insert(textField.text!, at: 0)
        UserDefaults.standard.set(notes, forKey: NOTE_ARR_KEY)
        selRow = 0
        UserDefaults.standard.set(selRow, forKey: NOTE_SEL_ROW_KEY)
        
        // 重新创建通知
        ReminderManager.shareManager().addReminder()
        
        textField.text = ""
        tableView.reloadData()
    }
}

// MARK: - textfield
extension ReminderNoteView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // 弹出一个黑色背景哦
        blackView = UIView()
        blackView!.backgroundColor = .black
        blackView!.alpha = 0.1
        blackView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        addSubview(blackView!)
        blackView!.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        return true
    }
    
    @objc func tap() {
        blackView?.removeFromSuperview()
        textField.resignFirstResponder()
    }
}
