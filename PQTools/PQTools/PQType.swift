
/*
 如果优雅的给一个类进行扩展 2 3 顺序可换
 1、新建一个自己的协议
 2、新建一个自己的结构体或者新建一个自己的类 final class ，并且继承于自己的协议
 3、为你想要扩展的类新增一个成员变量，使用自己的结构体进行初始化
 4、为自己的协议实现方法
 
 // 参考了RxSwift的设计模式
 */

public struct Reactive<Base> {
    /// Base object to extend.
    public let pq: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.pq = base
    }
}

/// A type that has reactive extensions.
public protocol ReactiveCompatible {
    /// Extended type
    associatedtype CompatibleType

    /// Reactive extensions.
    static var pq: Reactive<CompatibleType>.Type { get set }

    /// Reactive extensions.
    var pq: Reactive<CompatibleType> { get set }
}

extension ReactiveCompatible {
    /// Reactive extensions.
    public static var pq: Reactive<Self>.Type {
        get {
            return Reactive<Self>.self
        }
        set {
            // this enables using Reactive to "mutate" base type
        }
    }

    /// Reactive extensions.
    public var pq: Reactive<Self> {
        get {
            return Reactive(self)
        }
        set {
            // this enables using Reactive to "mutate" base object
        }
    }
}

import class Foundation.NSObject

/// Extend NSObject with `rx` proxy.
extension NSObject: ReactiveCompatible { }
