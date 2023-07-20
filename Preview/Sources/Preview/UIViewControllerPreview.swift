//
//  UIViewControllerPreview.swift
//  
//
//  Created by jun wook on 2023/07/15.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI
import UIKit

public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    public let viewController: ViewController
    
    public init(
        _ builder: @escaping () -> ViewController
    ) {
        viewController = builder()
    }
    
    // MARK: - UIViewControllerRepresentable
    public func makeUIViewController(
        context: Context
    ) -> ViewController {
        viewController
    }
    
    public func updateUIViewController(
        _ uiViewController: ViewController,
        context: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>
    ) {
        return
    }
}
#endif
