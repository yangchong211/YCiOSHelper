//
//  UIView+Extension.swift
//  FunIOS
//
//  Created by redli on 2021/7/25.
//

import UIKit

extension UIView {
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(x) {
            var frame = self.frame
            frame.origin.x = x
            self.frame = frame
        }
    }

    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(y) {
            var frame = self.frame
            frame.origin.y = y
            self.frame = frame
        }
    }

    var centerX: CGFloat {
        get {
            return center.x
        }
        set(centerX) {
            var center = self.center
            center.x = centerX
            self.center = center
        }
    }

    var centerY: CGFloat {
        get {
            return center.y
        }
        set(centerY) {
            var center = self.center
            center.y = centerY
            self.center = center
        }
    }

    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(width) {
            var frame = self.frame
            frame.size.width = width
            self.frame = frame
        }
    }

    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(height) {
            var frame = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }

    var size: CGSize {
        get {
            return frame.size
        }
        set(size) {
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
    }

    var origin: CGPoint {
        get {
            return frame.origin
        }
        set(origin) {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
}
