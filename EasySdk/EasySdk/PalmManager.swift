//
//  PalmManager.swift
//  WxPalmSdk
//
//  Created by 杨充 on 2024/12/13.
//

import Foundation
import UIKit
import AdSupport


public class PalmManager {
    
    //获取设备唯一标识
    public static func getDeviceIdentifier() -> String? {
        if let identifier = UIDevice.current.identifierForVendor?.uuidString {
            return identifier
        } else if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
            return ASIdentifierManager.shared().advertisingIdentifier.uuidString
        }
        return nil
    }
    
    //获取设备版本
    public static func getDeviceVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
}

