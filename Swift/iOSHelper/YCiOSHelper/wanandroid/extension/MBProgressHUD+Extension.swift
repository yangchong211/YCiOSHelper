//
//  MBProgressHUD+Extension.swift
//  FunIOS
//
//  Created by redli on 2021/8/4.
//

import UIKit
import MBProgressHUD
let HUD_Duration_Infinite = -1
let HUD_Duration_Normal = 1.5
let HUD_Duration_Short = 0.5

extension MBProgressHUD {
    @discardableResult
    class func showAdded(view: UIView, duration showTime: Double, animated: Bool) -> (MBProgressHUD) {
        var animated = animated
        let existHUD:MBProgressHUD = MBProgressHUD(view: view)
        if existHUD != nil{
            // 如果有HUD先隐藏掉，保证始终只有一个HUD
            MBProgressHUD.hide(for: view, animated: false)
            // 如果有HUD，则不做animation
            animated = false
        }
        
        let showView = self.showAdded(to: view, animated: animated)

        if Int(showTime) != HUD_Duration_Infinite {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(showTime * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                MBProgressHUD.hide(for: view, animated: false)
            })
        }
        return showView
    }

    @discardableResult
    class func showAdded(view: UIView, duration showTime: TimeInterval, withText text: String?, animated: Bool) -> (MBProgressHUD) {
        let showView = self.showAdded(view: view, duration: showTime, animated: animated)
        MBProgressHUD(view: view).isUserInteractionEnabled = false
        MBProgressHUD(view: view).mode = .text
        MBProgressHUD(view: view).label.text = text
        return showView
    }

    @discardableResult
    class func showAdded(view: UIView, icon image: UIImage?, duration showTime: TimeInterval, withText text: String?, animated: Bool) -> (MBProgressHUD) {
        let showView = self.showAdded(view: view, duration: showTime, animated: animated)
        MBProgressHUD(view: view).isUserInteractionEnabled = false
        MBProgressHUD(view: view).mode = .customView
        return showView
    }
}
