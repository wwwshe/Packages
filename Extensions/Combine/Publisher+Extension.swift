//
//  Publisher+Extension.swift
//
//

#if canImport(Combine)
    import Combine

    @available(iOS 13, *)
    public extension Publisher {
        func withUnretained<O: AnyObject>(_ owner: O) -> Publishers.CompactMap<Self, (O, Self.Output)> {
            compactMap { [weak owner] output in
                owner == nil ? nil : (owner!, output)
            }
        }
    }
#endif
