//
//  UIApplication+Ex.swift
//  Walsh
//

import UIKit

@available(iOSApplicationExtension, unavailable)
public extension UIDevice {
	
    var isNotch: Bool {
		if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first,
		   window.safeAreaInsets.bottom > 0.0 {
			return true
		}
        return false
    }
	
}
