## UIExtensions

이 모듈은 **UIKit / SwiftUI / 시스템 UI 타입에 대한 extension** 을 모아두는 곳입니다.

- `UIView+Extension`, `UILabel+Extension`, `UIButton+Extension` 처럼 기존 컴포넌트의 기능 확장
- 오토레이아웃 헬퍼 (`UIView+Constraint`, `UIStackView+Builder` 등)
- 접근성, 스크롤, 화면 크기 등 UI 동작 보조 extension

> 규칙  
> - 기존 UIKit / SwiftUI 타입에 **메서드/프로퍼티를 추가**하고 싶으면 여기로  
> - 새로운 뷰/컨트롤(컴포넌트)을 만들면 `CommonUI` 로, 디바이스/사이즈 유틸은 `UIUtility` 로 보냅니다.

