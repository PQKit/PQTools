//
//  PQSupportFiles.swift
//  PQ
//
//  Created by 盘国权 on 2018/12/15.
//  Copyright © 2018 pgq. All rights reserved.
//

import UIKit


//public extension NSObject{
public var PQScreenWidth: CGFloat {
    return PQScreenSize.width
}

public var PQScreenHeight: CGFloat {
    return PQScreenSize.height
}

public var PQScreenSize: CGSize {
    return PQScreenBouds.size
}

public var PQScreenBouds: CGRect {
    return UIScreen.main.bounds
}

public func PQiPhoneXBottom() -> CGFloat{
    if let window = UIApplication.shared.keyWindow {
        if window.frame.size == CGSize(width: 375, height: 812){
            return -20
        }
    }
    return -0
}

public func PQisIpad() -> Bool {
    return (UI_USER_INTERFACE_IDIOM() == .pad)
}

public func PQisiPhone() -> Bool {
    return (UI_USER_INTERFACE_IDIOM() == .phone)
}

public func PQisiPhoneX() -> Bool {
    let bounds = UIScreen.main.bounds
    return (bounds.width == 375) && (bounds.height == 812)
}

@discardableResult public func PQPrintData(_ item: Data?) -> Bool {
    if let data = item {
        var dataStr = "data is <0-3> "
        var i :Int = 0
        for c in data{
            dataStr.append(String(format: "%02x", c) )
            i += 1
            if i%4 == 0 {
                dataStr.append(" <\(i)-\(i+3)> ")
            }
            
        }
        PQPrint(dataStr)
        return true
    }
    
    PQPrint("empty Data")
    return false
}

public func PQPrint(_ items: Any...,  function:String = #function,file : String = #file, lineNumber : Int = #line){
    #if DEBUG
    //获取文件名
    let fileName = (file as NSString).lastPathComponent
    let interval = TimeZone.current.secondsFromGMT(for: Date())
    let date = Date().addingTimeInterval(TimeInterval(interval))
    //打印日志内容
    //        print("[日志] \(date) \(fileName):\(lineNumber) > \(function) info：\(items)")
    print("[日志] \(date) \(fileName):\(lineNumber) > \(function) ",items)
    #endif
}

public func PQLog<T>(message : T, file : String = #file, lineNumber : Int = #line) {
    
    #if DEBUG
    
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):line:\(lineNumber)]- \(message)")
    
    #endif
}

// 锁
public func PQSynchronized(lock: AnyObject, closure:()->()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

//关闭定时器
public func PQCloseTimer(_ timer:inout Timer?){
    timer?.invalidate()
    timer?.fireDate = Date.distantFuture
    timer = nil
}

// 创建定时器
public func PQOpenTimer(timeInterval: TimeInterval, target: Any, selector: Selector, repeats: Bool) -> Timer {
    let timer = Timer.scheduledTimer(timeInterval: timeInterval, target: target, selector: selector, userInfo: nil, repeats: repeats)
    RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    return timer
}
