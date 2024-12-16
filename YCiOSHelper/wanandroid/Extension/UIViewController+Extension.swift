//
//  UIViewController+Extension.swift
//  FunIOS
//
//  Created by redli on 2021/8/4.
//

import UIKit
import Foundation
import MBProgressHUD

private let minHUDWidth: CGFloat = 0.0

extension UIViewController {
    @discardableResult
    func showWaitHUD() -> MBProgressHUD {
        return showWaitHUD(title: "加载中…")
    }

    @discardableResult
    func showWaitHUD(title: String?) -> MBProgressHUD {
        let HUD = showHUD(title: title, duration: TimeInterval(HUD_Duration_Infinite))
        HUD.isUserInteractionEnabled = true
        return HUD
    }

    @discardableResult
    func showHUDWithError(error: String?) -> MBProgressHUD {
        return showHUD(title: error, duration: HUD_Duration_Normal)
    }

    @discardableResult
    func showHUD(title: String?) -> MBProgressHUD {
        return showHUD(title: title, duration: HUD_Duration_Normal)
    }

    @discardableResult
    func showHUD(title: String?, detail: String?) -> MBProgressHUD {
        return showHUD(title: title, detail: detail, duration: HUD_Duration_Normal)
    }

    @discardableResult
    func showHUD(title: String?, duration: TimeInterval) -> MBProgressHUD {
        return showHUD(title: "", detail: title, duration: duration)
    }

    @discardableResult
    func showHUD(title: String?, detail: String?, duration: TimeInterval) -> MBProgressHUD {
        var HUD:MBProgressHUD = MBProgressHUD()
        if hudContainerView() != nil {
            HUD = MBProgressHUD.showAdded(view: hudContainerView()!, duration: duration, withText: title, animated: true)
            HUD.detailsLabel.text = detail
            setHUDBelowNavigationBar()
            HUD.minSize = CGSize(width: minHUDWidth, height: 0.0)

        }
        return HUD
    }

    @discardableResult
    func showHUD(withTitle title: String?, detail: String?, topIcon iconImage: UIImage?, duration: TimeInterval) -> MBProgressHUD {
        let HUD = showHUD(title: title, detail: detail, duration: duration)
        HUD.mode = .customView
        HUD.customView = UIImageView(image: iconImage)
        return HUD
    }

    @discardableResult
    func showHUD(withTitle title: String?, error: Error?) -> MBProgressHUD {
        
        let errorDetail = error?.localizedDescription
        return showHUD(title: title, detail: errorDetail)
    }

    
    func hideHUD() {
        if hudContainerView() != nil {
            MBProgressHUD.hide(for: hudContainerView()!, animated: true)
        }
    }

    @discardableResult
    func hudContainerView() -> UIView? {
        if isViewLoaded {
                if parent != nil && parent != navigationController {
                    return parent?.hudContainerView()
                } else if navigationController?.parent != nil && navigationController?.parent != tabBarController {
                    return navigationController?.parent?.hudContainerView()
                } else {
                    return view
                }
        } else {
            return nil
        }
    }

    func setHUDBelowNavigationBar() {
        if navigationController?.view == hudContainerView() {
            if let navigationBar = navigationController?.navigationBar {
                if let hud = MBProgressHUD.forView((navigationController?.view)!) {
                    navigationController?.view.insertSubview(hud, belowSubview: navigationBar)
                }
                
            }
        }
    }
}
