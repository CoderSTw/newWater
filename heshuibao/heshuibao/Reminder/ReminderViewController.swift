//
//  ReminderViewController.swift
//  heshuibao
//
//  Created by 王磊 on 2019/12/20.
//  Copyright © 2019 erlingerling. All rights reserved.
//

import UIKit

class ReminderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setup()
    }
    
    //
    private var scrollView: UIScrollView!
    private var topview: RecordTopView!
    
    //
    private func setup() {
        //
        topview = RecordTopView(titles: ["时间", "铃声", "文字"])
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
        
        // time
        let timeView = ReminderTimeView()
        scrollView.addSubview(timeView)
        timeView.snp.makeConstraints { (make) in
            make.left.top.height.equalTo(scrollView)
            make.width.equalTo(SCREEN_WIDTH)
        }
        
        // ring
        let ringView = ReminderRingView()
        scrollView.addSubview(ringView)
        ringView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView).offset(SCREEN_WIDTH)
            make.top.height.equalTo(scrollView)
            make.width.equalTo(SCREEN_WIDTH)
        }
        
        // note
        let noteView = ReminderNoteView()
        scrollView.addSubview(noteView)
        noteView.snp.makeConstraints { (make) in
            make.left.equalTo(scrollView).offset(SCREEN_WIDTH*2)
            make.top.height.equalTo(scrollView)
            make.width.equalTo(SCREEN_WIDTH)
        }
    }
}

extension ReminderViewController: RecordTopViewDelegate, UIScrollViewDelegate {
    func RecordTopViewDidClickBtn(index: Int) {
        scrollView.setContentOffset(CGPoint.init(x: CGFloat(index)*SCREEN_WIDTH, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offX = scrollView.contentOffset.x
        topview.setOffX(index: Int(offX/SCREEN_WIDTH))
    }
    
}
