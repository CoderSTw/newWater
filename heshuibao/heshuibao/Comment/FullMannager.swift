//
//  FullMannager.swift
//  heshuibao
//
//  Created by 王磊 on 2020/1/17.
//  Copyright © 2020 erlingerling. All rights reserved.
//

import UIKit
import GoogleMobileAds

class FullMannager: NSObject, GADInterstitialDelegate {
    
    private var interstitial: GADInterstitial!
    
    static let instences_full: FullMannager = FullMannager()
    class func shareManager() -> FullMannager {
        return instences_full
    }

    func loadFull(vc: UIViewController, noHandle: @escaping (()->())) {
        let count = getcount()+1
        UserDefaults.standard.set(count, forKey: "fullcount")
        
        if count%3==0 {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: vc)
            }
        }else {
            // 不谈广告
            noHandle()
        }
        
    }
    
    func createAndLoadInterstitial() {
      interstitial = GADInterstitial(adUnitID: FULL_ID)
      interstitial.delegate = self
      interstitial.load(GADRequest())
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
      createAndLoadInterstitial()
    }
    
    private func getcount() -> Int {
        return UserDefaults.standard.integer(forKey: "fullcount")
    }
    
}
