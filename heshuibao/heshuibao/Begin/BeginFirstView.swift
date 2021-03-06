//
//  BeginFirstView.swift
//  heshuibao
//
//  Created by 舒蕾 on 2019/12/22.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class BeginFirstView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(150 + row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.IMGPX()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        heightRow = row
        UserDefaults.standard.set(heightRow, forKey: HEIGHT_ROW_KEY)
    }
    
    
    //
    private var heightRow = 15
    

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
        if UserDefaults.standard.integer(forKey: HEIGHT_ROW_KEY)==0 {
        }else {
            heightRow = UserDefaults.standard.integer(forKey: HEIGHT_ROW_KEY)
        }
        pickerView.selectRow(heightRow, inComponent: 0, animated: true)
        addSubview(pickerView)
        pickerView.snp.makeConstraints { (make) in
            make.top.equalTo(40.IMGPX())
            make.width.equalTo(self)
            make.bottom.equalTo(-40.IMGPX())
            make.centerX.equalTo(self)
        }
        
        let label = UILabel(title: " CM", color: .black, size: 18.IMGPX())
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(pickerView)
            make.right.equalTo(-100.IMGPX())
        }
        
        UserDefaults.standard.set(heightRow, forKey: HEIGHT_ROW_KEY)
    }
}
