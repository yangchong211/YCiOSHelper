//
//  PalmHelper.swift
//  PalmDaSdk
//
//  Created by 杨充 on 2024/12/13.
//

import Foundation
import UIKit

public class PalmHelper {
    
    //获取屏幕分辨率
    public static func getResolution() -> CGSize {
        let screenSize = UIScreen.main.bounds.size
        let scale = UIScreen.main.scale
        let resolution = CGSize(width: screenSize.width * scale, height: screenSize.height * scale)
        return resolution
    }
    
}



