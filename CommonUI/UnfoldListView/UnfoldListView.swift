//
//  UnfoldListView.swift
//
//  Created by JJW on 8/8/24.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxGesture

class UnfoldListView: UIView {
    enum Metric {
        static let leading: CGFloat = 10
        static let trailing: CGFloat = 10
    }
    
    var childViews: [UIView]
    
    /// 현재 선택되어있는 인덱스
    var selectIndex = 0
    
    /// 애니메이션(Spring)
    var animation: UIViewPropertyAnimator?
    
    private let disposeBag = DisposeBag()
    
    private var height: CGFloat
    
    /// 접혀져 있을 때 절반 높이
    private var halfHeight: CGFloat {
        height / 2
    }
    
    init(
        childViews: [UIView],
        height: CGFloat
    ) {
        self.childViews = childViews
        self.height = height
        super.init(frame: .zero)
        setupUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// child 뷰 변경
    public func setupChildViews(views: [UIView]) {
        self.childViews.forEach {
            $0.removeFromSuperview()
        }
        childViews = views
        setupUI()
        let selectIndex = selectIndex
        self.selectIndex = 0
        selectView(index: selectIndex, isAnimation: false)
    }
    
    private func setupUI() {
        for i in 0..<childViews.count {
            setChildView(index: i)
        }
    }
    
    private func bind() {
        for i in 0..<childViews.count {
            let view = childViews[i]
            view.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: { [weak self] _ in
                    guard let self = self else { return }
                    selectView(index: i)
                })
                .disposed(by: disposeBag)
        }
    }
    
    private func selectView(index: Int, isAnimation: Bool = true) {
        if index == 0 {
            foldAfterMiddles(index: index)
            foldLastView()
            selectIndex = 0
        } else if index == (childViews.count - 1) {
            updateLastView()
        } else {
            updateMiddleView(index: index)
        }
        
        if isAnimation {
            subviewAnimation(index: index)
            startAnimation()
        }
    }
}

extension UnfoldListView {
    /// 초기 뷰 셋팅
    private func setChildView(index: Int) {
        let view = childViews[index]
        self.addSubview(view)
        
        let frontViewCount = CGFloat(getFrontViewCount(index: index))
        
        if index == 0 {
            let bottomOffset = halfHeight * frontViewCount
            view.snp.makeConstraints {
                $0.top.equalToSuperview()
                $0.leading.equalTo(Metric.leading)
                $0.trailing.equalTo(-Metric.trailing)
                $0.bottom.equalTo(-bottomOffset)
            }
        } else if index == (childViews.count - 1) {
            foldLastView()
        } else {
            foldMiddleView(index: index)
        }
    }
}

// MARK: Unfold/Fold
extension UnfoldListView {
    /// 마지막 뷰 펼치기
    private func unfoldLastView() {
        let index = childViews.count - 1
        let view = childViews[index]
        let beforeView = childViews[index - 1]
        view.snp.remakeConstraints {
            $0.top.equalTo(beforeView.snp.top).offset(halfHeight)
            $0.leading.equalTo(Metric.leading)
            $0.trailing.equalTo(-Metric.trailing)
            $0.bottom.equalToSuperview()
        }
    }
    
    /// 마지막 뷰 접기
    private func foldLastView() {
        let index = childViews.count - 1
        let view = childViews[index]
        let beforeView = childViews[index - 1]
        view.snp.remakeConstraints {
            $0.top.equalTo(beforeView.snp.bottom).offset(-halfHeight)
            $0.leading.equalTo(Metric.leading)
            $0.trailing.equalTo(-Metric.trailing)
            $0.bottom.equalToSuperview()
        }
    }
    
    /// 중간 뷰 펼치기
    private func unfoldMiddleView(index: Int) {
        let view = childViews[index]
        let beforeView = childViews[index - 1]
        let frontViewCount = CGFloat(getFrontViewCount(index: index))
        let bottomOffset = halfHeight * frontViewCount
        view.snp.remakeConstraints {
            $0.top.equalTo(beforeView.snp.top).offset(halfHeight)
            $0.leading.equalTo(Metric.leading)
            $0.trailing.equalTo(-Metric.trailing)
            $0.bottom.equalTo(-bottomOffset)
        }
    }
    
    /// 중간 뷰 접기
    private func foldMiddleView(index: Int) {
        let view = childViews[index]
        let beforeView = childViews[index - 1]
        let frontViewCount = CGFloat(getFrontViewCount(index: index))
        let bottomOffset = halfHeight * frontViewCount
        view.snp.remakeConstraints {
            $0.top.equalTo(beforeView.snp.bottom).offset(-halfHeight)
            $0.leading.equalTo(Metric.leading)
            $0.trailing.equalTo(-Metric.trailing)
            $0.bottom.equalTo(-bottomOffset)
        }
    }
    
    /// 인덱스 뒤의 뷰들 접기(마지막뷰 제외)
    private func foldAfterMiddles(index: Int) {
        let lastView = childViews.last
        for i in (index + 1)..<childViews.count where (i < childViews.count) && (childViews[i] != lastView) {
            foldMiddleView(index: i)
        }
    }
    
    /// 인덱스 뒤의 뷰들 접기(첫번째 뷰는 제외)
    private func foldBeforeMiddles(index: Int) {
        for i in 1..<index {
            foldMiddleView(index: i)
        }
    }
    
    /// 인덱스 앞의 뷰들 펼치기(첫번째 뷰는 제외)
    private func unfoldBeforeMiddles(index: Int) {
        for i in 1..<index {
            unfoldMiddleView(index: i)
        }
    }
    
    /// 애니메이션 시작
    private func startAnimation(completion: (() -> Void)? = nil) {
        animation = UIViewPropertyAnimator(
            duration: 0.7,
            dampingRatio: 0.7
        ) { [weak self] in
            guard let self = self else { return }
            self.layoutIfNeeded()
        }
        
        animation?.addCompletion { _ in
            completion?()
        }
        
        animation?.startAnimation()
    }
    
    /// 중간 뷰 상태 업데이트
    private func updateMiddleView(index: Int) {
        if selectIndex == index {
            foldBeforeMiddles(index: index)
            foldMiddleView(index: index)
            selectIndex = 0
        } else {
            foldAfterMiddles(index: index)
            foldLastView()
            unfoldBeforeMiddles(index: index)
            unfoldMiddleView(index: index)
            selectIndex = index
        }
    }
    
    /// 마지막 뷰 상태 업데이트
    private func updateLastView() {
        let index = (childViews.count - 1)
        if selectIndex == index  {
            foldAfterMiddles(index: 0)
            foldLastView()
            selectIndex = 0
        } else {
            unfoldBeforeMiddles(index: index)
            unfoldLastView()
            selectIndex = index
        }
    }
    
    /// 현재 뷰 아래에 쌓여있는 뷰 갯수(마지막 뷰는 제외)
    private func getFrontViewCount(index: Int) -> Int {
        return (childViews.count - 2) - index
    }
   
    private func subviewAnimation(index: Int) {
        guard let view = childViews[index] as? UnfoldViewProtocol else { return }
        view.animation()
    }
}
