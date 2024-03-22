//
//  DeallocHooker.swift
//
//
//  Created by JJW on 2024/03/22.
//

import Foundation


final class DeallocHooker {
    private struct AssocciatedKey {
        static var deallocHookcer = "deallocHooker"
    }
    
    private let handler: () -> Void
    private init(_ handler: @escaping () -> Void) {
        self.handler = handler
    }
    
    deinit {
        print("DeallocHooker deinit")
        handler()
    }
    
    static func install(to object: AnyObject, _ handler: @escaping () -> Void) {
        objc_setAssociatedObject(
            object,
            &AssocciatedKey.deallocHookcer,
            DeallocHooker(handler),
            .OBJC_ASSOCIATION_RETAIN_NONATOMIC
        )
    }
}
