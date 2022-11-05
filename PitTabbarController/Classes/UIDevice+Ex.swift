//
//  UIApplication+Ex.swift
//  Walsh
//

import UIKit

@available(iOSApplicationExtension, unavailable)
public extension UIDevice {
	
    var isNotch: Bool {
		if let bottom = keyWindow?.safeAreaInsets.bottom, bottom > 0.0 {
			return true
		}
        return false
    }
	
}
