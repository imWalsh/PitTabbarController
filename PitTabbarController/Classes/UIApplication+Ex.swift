//
//  UIApplication+Ex.swift
//  Walsh
//

import UIKit

@available(iOSApplicationExtension, unavailable)
public extension UIDevice {
	
    var isNotch: Bool {
		if let mainWindow = UIApplication.shared.delegate?.window,
		   let bottom = mainWindow?.safeAreaInsets.bottom, bottom > 0.0 {
			return true
		}
        return false
    }
	
}
