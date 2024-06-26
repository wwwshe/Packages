//
//  UIViewControllerPreview.swift
//
//
//  Created by jun wook on 2023/07/15.
//

#if canImport(SwiftUI) && canImport(UIKit) && DEBUG
    import SwiftUI
    import UIKit

    @available(iOS 13.0, *)
    public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
        public let viewController: ViewController

        public init(
            _ builder: @escaping () -> ViewController
        ) {
            viewController = builder()
        }

        // MARK: - UIViewControllerRepresentable

        public func makeUIViewController(
            context _: Context
        ) -> ViewController {
            viewController
        }

        public func updateUIViewController(
            _: ViewController,
            context _: UIViewControllerRepresentableContext<UIViewControllerPreview<ViewController>>
        ) {}
    }
#endif
