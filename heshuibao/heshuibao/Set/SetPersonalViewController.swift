//
//  SetPersonalViewController.swift
//  heshuibao
//
//  Created by 舒蕾 on 2020/1/14.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit

class SetPersonalViewController: UIViewController {

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
        
        let toplabel = UILabel(title: "个人资料", color: .white, size: 18.IMGPX(), weight: .medium)
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
        
        //
        tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(SetCell.self, forCellReuseIdentifier: "Set_Personal_Cell")
        tableview.backgroundColor = .white
        tableview.rowHeight = 65.IMGPX()
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        tableview.backgroundColor = COLOR_BGCOLOR
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.bottom.equalTo(view)
            make.top.equalTo(topview.snp_bottom).offset(30.IMGPX())
            make.left.equalTo(30.IMGPX())
            make.right.equalTo(-30.IMGPX())
        }
        
        //
        iconview = UIImageView(image: UIImage(named: "icon"))
        iconview.cornerRadius(radius: 5.IMGPX())
        let path = NSHomeDirectory()
        let imagePath = path + "/Documents/icon.png"
        let image = UIImage(contentsOfFile: imagePath)
        if (image != nil) {
            iconview.image = image
        }
        tableview.addSubview(iconview)
        iconview.snp.makeConstraints { (make) in
            make.top.equalTo(tableview.snp_top).offset(20.IMGPX())
            make.left.equalTo(tableview).offset(292.IMGPX())
            make.width.height.equalTo(33.IMGPX())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    private var iconnames = ["advance", "neal", "height", "weight", "gender"]
    private var titles = ["头像", "昵称", "身高", "体重", "性别"]
    private var details = ["", "\(UserDefaults.standard.string(forKey: NEAL_NAME_KEY)!)", "\(UserDefaults.standard.integer(forKey: HEIGHT_ROW_KEY)+150) CM", "\(UserDefaults.standard.integer(forKey: WEIGHT_ROW_KEY)+30) KG", "\(UserDefaults.standard.integer(forKey: GENDER_NUM_KEY)==0 ? "男" : "女")"]
    private var iconview: UIImageView!
    private var tableview: UITableView!
}

extension SetPersonalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Set_Personal_Cell", for: indexPath) as! SetCell
        
        cell.iconName = iconnames[indexPath.row]
        cell.titleName = titles[indexPath.row]
        cell.detailName = details[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==0 {
            // 头像
            iconClick()
        }else if indexPath.row==1 {
            // 昵称
            nealClick()
        }else if indexPath.row==2 {
            // 身高
            heightClick()
        }else if indexPath.row==3 {
            // 体重
            weightClick()
        }else {
            // 性别
            genderClick()
        }
    }
    
    private func iconClick() {
        
        WLHUD.shareHud().show()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == false {
            WLHUD.shareHud().showWithError(name: "打开相册失败！")
            WLHUD.shareHud().removeAnimate()
            return
        }
        
        let picker = UIImagePickerController.init()
        picker.delegate = self
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true) {
            WLHUD.shareHud().removeAnimate()
        }
    }
    
    private func nealClick() {
        let nealview = SetNealView()
        nealview.show()
        nealview.nealviewOKBlock = { [weak self] in
            self?.updateData()
        }
    }
    
    private func heightClick() {
        let heightview = SetHeightView()
        heightview.heightviewOKBlock = { [weak self] in
            self?.updateData()
        }
    }
    
    private func weightClick() {
        let weightview = SetWeightView()
        weightview.weightviewOKBlock = { [weak self] in
            self?.updateData()
        }
    }
    
    private func genderClick() {
        let genderview = SetGenderView()
        genderview.genderviewOKBlock = { [weak self] in
            self?.updateData()
        }
    }
    
    private func updateData() {
        details = ["", "\(UserDefaults.standard.string(forKey: NEAL_NAME_KEY)!)", "\(UserDefaults.standard.integer(forKey: HEIGHT_ROW_KEY)+150) CM", "\(UserDefaults.standard.integer(forKey: WEIGHT_ROW_KEY)+30) KG", "\(UserDefaults.standard.integer(forKey: GENDER_NUM_KEY)==0 ? "男" : "女")"]
        tableview.reloadData()
    }
}

// MARK: - 选取头像的代理
extension SetPersonalViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 1. 取出图片
        let img = info[UIImagePickerController.InfoKey.editedImage]
        
        // 2. 设置头像
        self.iconview.image = img as? UIImage
        
        // 3. 存入沙盒
        let path = NSHomeDirectory()
        let imagePath = path + "/Documents/icon.png"
        let data = UIImage.jpegData(img as! UIImage)(compressionQuality: 0.5)! as NSData
        data.write(toFile: imagePath, atomically: true)

        // 4. 关闭选择器
        picker.dismiss(animated: true, completion: nil)
    }
}

extension SetPersonalViewController {
    @objc func backBtnClick() {
        navigationController?.popViewController(animated: true)
    }
}
