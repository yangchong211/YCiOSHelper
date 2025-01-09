//
//  ExtensionBundle.swift
//  EasySdk
//
//  Created by 杨充 on 2024/12/23.
//

import Foundation

public extension Bundle {

    class func bundleForClass(_ aclass: AnyClass,bundleName: String) -> Bundle? {
        let bundle = Bundle(for: aclass)
        guard let bundleURL = bundle.url(forResource: bundleName, withExtension: "bundle")
            else {
            return nil
        }
        let resourceBundle = Bundle(url: bundleURL)
        return resourceBundle
    }
    
}


class BundleModel {
    
    class func bundle() -> Bundle {
        let bundle = Bundle(for: BundleModel.self)
        guard let bundleURL = bundle.url(forResource: "videoPalyerResource", withExtension: "bundle") else { return Bundle.main }
        
        guard let resourceBundle = Bundle(url: bundleURL) else { return Bundle.main }
        return resourceBundle
    }
}
