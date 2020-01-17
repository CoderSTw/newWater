//
//  TodayDrinkView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/20.
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
            let label = UILabel(title: valueNums[row], color: COLOR_MAINTEXTCOLOR, size: 22.IMGPX())
            view.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.center.equalTo(view)
            }
            return view
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45.IMGPX()
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
    
    private var bgView: UIView!
    private var bottomView: UIView!
    
    private func setup() {
        
        //
        bgView = UIView()
        bgView.alpha = 0
        bgView.backgroundColor = .black
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
        addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        //
        bottomView = UIView()
        bottomView.backgroundColor = COLOR_BGCOLOR
        bottomView.cornerRadius(radius: 15.IMGPX())
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(275.IMGPX())
            make.bottom.equalTo(30.IMGPX())
            make.width.equalTo(375.IMGPX())
        }
        bottomView.transform = .init(translationX: 0, y: 800.IMGPX())
        
        //
        let titleLabel = UILabel(title: "请选择本次饮品", color: COLOR_MAINTEXTCOLOR, size: 18.IMGPX())
        bottomView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(20.IMGPX())
            make.top.equalTo(30.IMGPX())
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
            make.top.equalTo(titleLabel.snp_bottom).offset(50.IMGPX())
            make.height.equalTo(250.IMGPX())
        }
        
        let view = UIView()
        view.backgroundColor = UIColor(r: 241, g: 242, b: 246)
        bottomView.insertSubview(view, belowSubview: pickerView)
        view.snp.makeConstraints { (make) in
            make.left.right.centerY.equalTo(pickerView)
            make.height.equalTo(45.IMGPX())
        }
        
        //
        let addBtn = UIButton()
        addBtn.setBackgroundImage(UIImage(named: "nextBtn"), for: .normal)
        addBtn.addTarget(self, action: #selector(addBtnClick), for: .touchUpInside)
        bottomView.addSubview(addBtn)
        addBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(pickerView.snp_bottom).offset(32.IMGPX() + NEW_AREA*2)
            make.width.equalTo(300.IMGPX())
            make.height.equalTo(64.IMGPX())
        }
        
        let addLabel = UILabel(title: "添加", color: .white, size: 18.IMGPX(), weight: .bold)
        addBtn.addSubview(addLabel)
        addLabel.snp.makeConstraints { (make) in
            make.center.equalTo(addBtn)
        }
        
    }
}

extension TodayDrinkView {
    @objc func tap() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
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
        addItem.Add()
        
        // 退出
        tap()
        self.delegate?.TodayDrinkViewDidClickDrinkBtn()
    }
    
    func animate() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.bgView.alpha = 0.2
            self.bottomView.transform = .identity
        }) { (_) in
            
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
            make.centerX.equalTo(self.snp_left).offset(58.IMGPX())
            make.width.height.equalTo(25.IMGPX())
        }
        
        let label = UILabel(title: titleName, color: COLOR_MAINTEXTCOLOR, size: 22.IMGPX())
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(90.IMGPX())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
