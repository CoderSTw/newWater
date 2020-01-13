//
//  RecordViewController.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //
        todayView.reloadData()
        weekView.reloadData()
    }
    
    //
    private var scrollView: UIScrollView!
    private var topview: RecordTopView!
    private var todayView: RecordTodayView!
    private var weekView: RecordWeekView!
    
    //
    private func setup() {
        
        // topview
        topview = RecordTopView(titles: ["今日", "本周", "全部"])
        topview.delegate = self
        view.addSubview(topview)
        
        // scrollView
        scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: SCREEN_WIDTH*3, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(view)
            make.top.equalTo(topview.snp_bottom)
            make.width.equalTo(SCREEN_WIDTH)
            make.bottom.equalTo(view)
        }
        
        // today
        todayView = RecordTodayView()
        scrollView.addSubview(todayView)
        todayView.snp.makeConstraints { (make) in
            make.left.top.height.equalTo(scrollView)
            make.width.equalTo(SCREEN_WIDTH)
        }
        
        // week
        weekView = RecordWeekView()
        scrollView.addSubview(weekView)
        weekView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView).offset(SCREEN_WIDTH)
            make.top.height.equalTo(scrollView)
            make.width.equalTo(SCREEN_WIDTH)
        }
        
        // all
        let allView = RecordAllView()
        scrollView.addSubview(allView)
        allView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView).offset(SCREEN_WIDTH*2)
            make.top.height.equalTo(scrollView)
            make.width.equalTo(SCREEN_WIDTH)
        }
    }

}

extension RecordViewController: RecordTopViewDelegate, UIScrollViewDelegate {
    func RecordTopViewDidClickBtn(index: Int) {
        scrollView.setContentOffset(CGPoint.init(x: CGFloat(index)*SCREEN_WIDTH, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offX = scrollView.contentOffset.x
        topview.setOffX(index: Int(offX/SCREEN_WIDTH))
    }
}
