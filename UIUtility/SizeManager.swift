//
//  SizeManager.swift
//
//

import UIKit

/// 스크린 사이즈를 가져오기 위한 안전한 모델입니다.
public struct SizeManager {
    public static let screenWidth: CGFloat = screenFrame.width

    public static let screenHeight: CGFloat = screenFrame.height

    public static let screenFrame: CGRect = {
        if let currentWindow {
            return currentWindow.frame
        } else {
            return UIScreen.main.bounds
        }
    }()

    public static var currentWindow: UIWindow? = {
        if #available(iOS 13, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                return window
            } else {
                return nil
            }
        } else {
            let window = UIApplication.shared.keyWindow
            return window
        }
    }()

    private init() {}
}
