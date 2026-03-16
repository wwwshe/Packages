## UIUtility

이 모듈은 화면 전반에서 사용하는 **UI 헬퍼/유틸리티**를 담는 곳입니다.

- `DeviceType`, `SizeManager` 처럼 디바이스/사이즈/레이아웃 계산
- `NiblessUIView`, `PaddingLabel`, `DotLabel` 처럼 가벼운 헬퍼 뷰

> 규칙  
> - 디바이스 정보, 스크린 사이즈, 인셋/마진 계산 등 **상태/레이아웃 유틸**은 여기로  
> - 공통 화면 컴포넌트는 `CommonUI`, UIKit extension 은 `UIExtensions` 로 보냅니다.

