//
//  DotLabel.swift
//
//

import UIKit

/// 레이블 앞에 점이 추가되는 UILabel 서브 클래스
///
/// 생성시 Configuration을 커스텀 하면, Dot의 사이즈 또는 레이블과의 간격을 조정할 수 있습니다.
///
/// > Example:
/// ```
/// let config = DotLabel.Configuration(
///     dotSize: 5,
///     spacing: 10,
///     color: .red
/// )
/// let dotLabel = DotLabel(configuration: config)
/// ```
/// or
/// ```
/// let dotLabel = DotLabel()
/// // default Configuration 을 사용합니다.
/// ```
public class DotLabel: UILabel {
    
    public struct Configuration {
        
        public static let `default` = Configuration()
        
        let dotSize: CGSize
        var dotHalfSize: CGFloat {
            dotSize.width / 2
        }
        var cornerRadius: CGFloat {
            dotHalfSize
        }
        let spacing: CGFloat
        
        let inset: UIEdgeInsets
        let color: UIColor
        
        public init(
            dotSize: CGFloat = 3,
            spacing: CGFloat = 8,
            color: UIColor = .black
        ) {
            self.spacing = spacing
            self.dotSize = CGSize(width: dotSize, height: dotSize)
            self.inset = UIEdgeInsets(top: 0, left: dotSize + spacing, bottom: 0, right: 0)
            self.color = color
        }
    }
    
    private let configuration: Configuration
    private var dotLayer: CALayer!
    
    public init(configuration: Configuration = .default) {
        self.configuration = configuration
        super.init(frame: .zero)
        drawDot()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let height = font.lineHeight
        dotLayer.frame.origin.y = (height / 2) - configuration.dotHalfSize
    }
    
    // swiftlint:disable auto_generated_leftovers
    public override func drawText(in rect: CGRect) {
        let newRect = CGRect(
            x: rect.origin.x + configuration.inset.left,
            y: rect.origin.y,
            width: rect.width - configuration.inset.left,
            height: rect.height)
        super.drawText(in: newRect)
    }
    
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        return super.textRect(forBounds: bounds.inset(by: configuration.inset), limitedToNumberOfLines: numberOfLines)
    }
    
    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func drawDot() {
        let layer = CALayer()
        layer.backgroundColor = configuration.color.cgColor
        layer.frame = CGRect(origin: .zero, size: configuration.dotSize)
        layer.cornerRadius = configuration.cornerRadius
        self.layer.addSublayer(layer)
        self.dotLayer = layer
    }
}

#if DEBUG && canImport(SwiftUI)
import SwiftUI
// swiftlint:disable all
extension DotLabel {
    @available(iOS 13.0, *)
    struct Preview: UIViewRepresentable {
        typealias UIViewType = DotLabel
        
        func makeUIView(context: Context) -> DotLabel {
            let label = DotLabel()
            label.text = "콘텐츠입니다"
            return label
        }
        
        func updateUIView(_ uiView: DotLabel, context: Context) {
            
        }
    }
}

@available(iOS 13.0, *)
struct DotLabels_Previews: PreviewProvider {
    static var previews: some View {
        DotLabel.Preview()
    }
}
#endif
