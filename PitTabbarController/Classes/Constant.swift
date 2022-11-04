//
//  Constant.swift
//  PitTabbarController
//
//  Created by Walsh
//

import Foundation

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let topSafeAreaHeight: CGFloat = UIDevice.current.isNotch ? 44 : 20
let bottomSafeAreaHeight: CGFloat = UIDevice.current.isNotch ? 34 : 0

let navigationBarHeight: CGFloat = topSafeAreaHeight + 44
let tabBarHeight: CGFloat = bottomSafeAreaHeight + 49

