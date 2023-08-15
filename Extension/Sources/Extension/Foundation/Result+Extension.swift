//
//  Result+Extension.swift
//
//

// success 가 Void인 경우 가독성을 높이기 위해 사용
public extension Swift.Result where Success == Void {
  static func success() -> Self { .success(()) }
}
