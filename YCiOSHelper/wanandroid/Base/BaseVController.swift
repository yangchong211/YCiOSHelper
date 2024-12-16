//
//  BaseVController.swift
//  FunIOS
//
//  Created by redli on 2021/9/6.
//

import Foundation
import UIKit
import LGButton


class BaseCVontroller: UIViewController{
    
    var floatAnimal = false
    
    var floatButton = UIButton().then({attr in
        attr.setImage(UIImage(named: "ic_top"), for: .normal)
        attr.contentMode = .scaleToFill
        attr.isHidden = true
    })
    
    func error(error: String?) {
//        view.makeToast(error)
        showHUDWithError(error: error)
    }
}
