//
//  DeviceType.swift
//
//
//  Created by jjw-Macbook Pro on 2023/07/25.
//

import UIKit

public enum DeviceType {
    public static let IS_IPAD = (UI_USER_INTERFACE_IDIOM() == .pad)
    public static let IS_IPHONE = (UI_USER_INTERFACE_IDIOM() == .phone)
    public static let IS_RETINA = UIScreen.main.scale >= 2.0

    public static let SCREEN_WIDTH = UIScreen.main.bounds.width
    public static let SCREEN_HEIGHT = UIScreen.main.bounds.height

    public static let SCREEN_MAX_LENGTH = max(SCREEN_WIDTH, SCREEN_HEIGHT)
    public static let SCREEN_MIN_LENGTH = min(SCREEN_WIDTH, SCREEN_HEIGHT)

    public static let IS_WIDTH_320 = (IS_IPHONE && SCREEN_WIDTH <= 320.0)
    public static let IS_IPHONE_4_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
    public static let IS_IPHONE_5_OR_LESS = (IS_IPHONE && SCREEN_MAX_LENGTH <= 568.0)
    public static let IS_IPHONE_5 = (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
    public static let IS_IPHONE_6 = (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
    public static let IS_IPHONE_6P = (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
    public static let IS_IPHONE_X = (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)
    public static let IS_IPHONE_X_OR_OVER = (IS_IPHONE && SCREEN_MAX_LENGTH >= 812.0)
}
