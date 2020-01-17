//
//  BeginSecondView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/22.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class BeginSecondView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

   func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 70
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(30 + row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.IMGPX()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        weightRow = row
        UserDefaults.standard.set(weightRow, forKey: WEIGHT_ROW_KEY)
    }
    
    
    //
    private var weightRow = 20
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        if UserDefaults.standard.integer(forKey: WEIGHT_ROW_KEY)==0 {
        }else {
            weightRow = UserDefaults.standard.integer(forKey: WEIGHT_ROW_KEY)
        }
        pickerView.selectRow(weightRow, inComponent: 0, animated: true)
        addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.top.equalTo(40.IMGPX())
            make.width.equalTo(self)
            make.bottom.equalTo(-40.IMGPX())
            make.centerX.equalTo(self)
        }
        
        let label = UILabel(title: " KG", color: .black, size: 18.IMGPX())
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(pickerView)
            make.right.equalTo(-100.IMGPX())
        }
        
        UserDefaults.standard.set(weightRow, forKey: WEIGHT_ROW_KEY)
    }

}
