//
//  AtomicWrapper.swift
//
//

import Foundation

@propertyWrapper
public final class Atomic<T>: NSLock {
    public var wrappedValue: T {
        get {
            lock()
            defer { unlock() }
            return value
        }

        _modify {
            lock()
            var tmp: T = value

            defer {
                value = tmp
                unlock()
            }

            yield &tmp
        }
    }

    private var value: T

    public init(wrappedValue: T) {
        value = wrappedValue
    }
}
