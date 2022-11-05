//
//  Constant.swift
//  PitTabbarController
//
//  Created by Walsh
//

import Foundation

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let keyWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first

let topSafeAreaHeight: CGFloat = keyWindow?.safeAreaInsets.top ?? 0
let bottomSafeAreaHeight: CGFloat = keyWindow?.safeAreaInsets.bottom ?? 0

let navigationBarHeight: CGFloat = topSafeAreaHeight + 44
let tabBarHeight: CGFloat = bottomSafeAreaHeight + 49

