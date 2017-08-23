//
//  GXDevelopSwiftObjectInit.swift
//  EarthSpirit
//
//  Created by 小新 on 2017/6/17.
//  Copyright © 2017年 KarlSW. All rights reserved.
//

// swift 便利构造方法

import Foundation

public protocol GXInit {}

//extension GXInit where Self: Any {
//    public func gxInit( block: (inout Self) -> Void) -> Self {
//        var copy = self
//        block(&copy)
//        return copy
//    }
//}

extension GXInit where Self: AnyObject {
    public func gxInit(_ block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: GXInit {}
