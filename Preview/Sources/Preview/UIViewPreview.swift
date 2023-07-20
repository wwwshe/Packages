//
//  UIViewPreview.swift
//  
//
//  Created by jun wook on 2023/07/15.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI
import UIKit

public struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    public init(
        _ builder: @escaping () -> View
    ) {
        view = builder()
    }
    
    // MARK: - UIViewRepresentable
    
    public func makeUIView(
        context: Context
    ) -> UIView {
        return view
    }
    
    public func updateUIView(
        _ view: UIView,
        context: Context
    ) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif
