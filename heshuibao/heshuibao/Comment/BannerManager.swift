//
//  BannerManager.swift
//  heshuibao
//
//  Created by 王磊 on 2020/1/17.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit
import GoogleMobileAds

class BannerManager: NSObject, GADBannerViewDelegate {
    func loadBanner(vc: UIViewController) {
        let adSize = GADAdSizeFromCGSize(CGSize(width: SCREEN_WIDTH, height: 50))
        let bannerView = GADBannerView(adSize: adSize)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.delegate = self
        vc.view.addSubview(bannerView)
        bannerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(vc.view)
            make.bottom.equalTo(-NEW_AREA - 50)
        }
        
        bannerView.adUnitID = HENGFU_ID
        bannerView.rootViewController = vc
        bannerView.load(GADRequest())
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      bannerView.alpha = 0
      UIView.animate(withDuration: 1, animations: {
        bannerView.alpha = 1
      })
    }
}
