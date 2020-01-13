//
//  TodayDrinkView.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

protocol TodayDrinkViewDelegate: NSObject {
    func TodayDrinkViewDidClickDrinkBtn()
}

class TodayDrinkView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component==0 ? titleNames.count : valueNums.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component==0 {
            let drinkItemView = DrinkItemView(imgName: imgNames[row], titleName: titleNames[row])
            return drinkItemView
        }else {
            let view = UIView()
            let label = UILabel(title: valueNums[row], color: COLOR_MAINTEXTCOLOR, size: 22.imgSize())
            view.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.center.equalTo(view)
            }
            return view
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45.imgSize()
    }
    

    //
    private let valueNums = ["50 ML", "100 ML", "150 ML", "200 ML", "250 ML", "300 ML"]
    private let values = [50, 100, 150, 200, 250, 300]
    private let imgNames = ["itemCola", "itemCoffee", "itemWater", "itemMilk", "itemTea"]
    private let titleNames = ["饮料", "咖啡", "水", "牛奶", "茶"]
    private var pickerView: UIPickerView!
    weak var delegate: TodayDrinkViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        //
        let bgView = UIView()
        bgView.alpha = 0.2
        bgView.backgroundColor = .black
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        //
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        bottomView.cornerRadius(radius: 15.imgSize())
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(275.imgSize())
            make.bottom.equalTo(30.imgSize())
            make.width.equalTo(375.imgSize())
        }
        
        //
        let titleLabel = UILabel(title: "请选择本次饮品", color: COLOR_MAINTEXTCOLOR, size: 18.imgSize())
        bottomView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20.imgSize())
            make.top.equalTo(30.imgSize())
        }
        
        //
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(2, inComponent: 0, animated: true)
        pickerView.selectRow(2, inComponent: 1, animated: true)
        bottomView.addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.left.right.equalTo(bottomView)
            make.top.equalTo(titleLabel.snp_bottom).offset(50.imgSize())
            make.height.equalTo(250.imgSize())
        }
        
        let view = UIView()
        view.backgroundColor = UIColor(r: 241, g: 242, b: 246)
        bottomView.insertSubview(view, belowSubview: pickerView)
        view.snp.makeConstraints { (make) in
            make.left.right.centerY.equalTo(pickerView)
            make.height.equalTo(45.imgSize())
        }
        
        //
        let addBtn = UIButton()
        addBtn.setBackgroundImage(UIImage(named: "nextBtn"), for: .normal)
        addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
        bottomView.addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(pickerView.snp_bottom).offset(90.imgSize())
            make.width.equalTo(300.imgSize())
            make.height.equalTo(64.imgSize())
        }
        
        let addLabel = UILabel(title: "添加", color: .white, size: 18.imgSize(), weight: .bold)
        addBtn.addSubview(addLabel)
        addLabel.snp.makeConstraints { (make) in
            make.center.equalTo(addBtn)
        }
        
    }
}

extension TodayDrinkView {
    @objc func tap() {
        removeFromSuperview()
    }
    
    @objc func addBtnClick() {
        // TODO:
        let addItem = TodayAddItem()
        addItem.imgName = imgNames[pickerView.selectedRow(inComponent: 0)]
        addItem.waterName = titleNames[pickerView.selectedRow(inComponent: 0)]
        addItem.mlValue = valueNums[pickerView.selectedRow(inComponent: 1)]
        let fmt = DateFormatter()
        fmt.dateFormat = "HH : mm"
        addItem.time = fmt.string(from: Date())
        TodayViewModel.addTodayCount(value: values[pickerView.selectedRow(inComponent: 1)])
        addItem.progress = TodayViewModel.getProgress()
//        addItem.my_print()
        addItem.Add()
        
        // 退出
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 0
        }) { (_) in
            self.delegate?.TodayDrinkViewDidClickDrinkBtn()
            self.tap()
        }
    }
}

class DrinkItemView: UIView {
    init(imgName: String, titleName: String) {
        super.init(frame: CGRect.zero)
        
        let imgView = UIImageView(image: UIImage(named: imgName))
        imgView.contentMode = .scaleAspectFit
        addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self.snp_left).offset(58.imgSize())
            make.width.height.equalTo(25.imgSize())
        }
        
        let label = UILabel(title: titleName, color: COLOR_MAINTEXTCOLOR, size: 22.imgSize())
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(90.imgSize())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
