
import UIKit

/*
public enum PQPushType: String {
    /// wifi
    case wifi =             "A p p - P r e f s : r o o t = WIFI"
    /// bluetooth
    case bluetooth =        "A p p - P r e f s : r o o t = Bluetooth"
    /// 蜂窝移动网络
    case wwan =             "A p p - P r e f s : r o o t = MOBILE_DATA_SETTINGS_ID"
    /// 热点
    case ap =               "A p p - P r e f s : r o o t = INTERNET_TETHERING"
    /// 运营商
    case carrier =          "A p p - P r e f s : r o o t = Carrier"
    /// 通知
    case noti =             "A p p - P r e f s : r o o t = NOTIFICATIONS_ID"
    /// 通用
    case general =          "A p p - P r e f s : r o o t = General"
    /// 关于手机
    case aboutPhone =       "A p p - P r e f s : r o o t = General&path=About"
    /// 键盘
    case keybaord =         "A p p - P r e f s : r o o t = General&path=Keyboard"
    /// 辅助功能
    case accessibility =    "A p p - P r e f s : r o o t = General&path=ACCESSIBILITY"
    /// 语言地区
    case region =           "A p p - P r e f s : r o o t = General&path=INTERNATIONAL"
    /// 重置手机
    case reset =            "A p p - P r e f s : r o o t = Reset"
    /// 墙纸
    case wallpaper =        "A p p - P r e f s : r o o t = Wallpaper"
    /// siri
    case siri =             "A p p - P r e f s : r o o t = SIRI"
    /// 隐私
    case privacy =          "A p p - P r e f s : r o o t = Privacy"
    /// safari
    case safari =           "A p p - P r e f s : r o o t = SAFARI"
    /// 音乐
    case music =            "A p p - P r e f s : r o o t = MUSIC"
    /// 音乐均衡器
    case musicEQ =          "A p p - P r e f s : r o o t = MUSIC&path=com.apple.Music:EQ"
    /// 照片与相机
    case photo =            "A p p - P r e f s : r o o t = Photos"
    /// facetime
    case facetime =         "A p p - P r e f s : r o o t = FACETIME"
    case vpn =              "A p p - P r e f s : r o o t = General&path=Network/VPN"
}*/

public class PQHUD: NSObject {
    
    public typealias PushCallbackClosure = (Error?) -> Void
    
    static let shared: PQHUD = PQHUD()
    public static var dismissTimeInterval: TimeInterval = 0.75
    
    #if false
    public class func push(_ type: PQPushType){
        push(type.rawValue.split(separator: " ").map(String.init).reduce("", { $0 + $1 }))
    }
    
    /// 跳转到WIFI设置界面
    public class func jumpToWIFI(){
        push(.wifi)
    }
    
    public class func jumpToMusic(){
        push(.music)
    }
    public class func jumpToNoti(){
        push(.noti)
    }
    
    #endif
    
    class func push(_ string: String, completion: PushCallbackClosure? = nil){
        var error: Error? = nil
        defer { completion?(error) }
        guard let url = URL(string: string) else {
            error = NSError(domain: "Invalid string", code: NSCoderValueNotFoundError, userInfo: ["msg": "Can not convert url: \(string)"])
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    public class func jumpToMyAppSet(_ completion: PushCallbackClosure? = nil){
        push(UIApplication.openSettingsURLString, completion: completion)
    }
    
    public class func defaultSetHUD(_ block: (() -> ())?){
        SVProgressHUD.setMinimumDismissTimeInterval(50)
        //设置遮罩模式 不允许用户操作N
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setAnimationCurve(.linear)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 15))
        
        block?()
    }
    
    /// 设置遮罩
    ///
    /// - Parameter mask: 遮罩
    public class func setMask(_ mask : SVProgressHUDMaskType){
        SVProgressHUD.setDefaultMaskType(mask)
    }
    
    
    /// 显示HUD
    @discardableResult
    public class func show() -> PQHUD {
        SVProgressHUD.show()
        return shared
    }
    
    /// 显示一段文字，带转圈动画
    ///
    /// - Parameter status: 文字
    @discardableResult
    public class func show(_ status : String? = nil) -> PQHUD {
        SVProgressHUD.show(withStatus: status)
        return shared
    }
    
    /// 设置文字,带感叹号
    ///
    /// - Parameter info: 文字
    @discardableResult
    public class func showInfo(_ info : String? = nil) -> PQHUD {
        SVProgressHUD.showInfo(withStatus: info)
        return shared
    }
    
    /// 显示一张图片
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - status: 文字
    @discardableResult
    public class func showImage(_ image :UIImage , status : String? = nil) -> PQHUD {
        SVProgressHUD.show(image, status: status)
        return shared
    }
    
    /// 显示错误信息，会显示一个x
    ///
    /// - Parameter status: 文字
    @discardableResult
    public class func showError(_ status: String? = nil) -> PQHUD {
        SVProgressHUD.showError(withStatus: status)
        return shared
    }
    
    /// 显示进度
    ///
    /// - Parameter progress: 进度
    @discardableResult
    public class func showProgress(_ progress : Float) -> PQHUD {
        SVProgressHUD.showProgress(progress)
        return shared
    }
    
    
    /// show GIF image from image named, status default is nil
    ///
    /// - Parameters:
    ///   - imageNamed: named
    ///   - status: default is nil
    /// - Returns: QFHUD
    @discardableResult
    public class func showGIFImage(named imageNamed: String, status: String? = nil) -> PQHUD {
        if let image = PQGIFImage.image(withGIFNamed: imageNamed) {
            SVProgressHUD.show(image, status: status)
        }else{
            showError("Image is nil, can not show it").dismiss()
        }
        return shared
    }
    
    /// show GIF image from data, status default is nil
    ///
    /// - Parameters:
    ///   - imageData: data
    ///   - status: default is nil
    /// - Returns: QFHUD
    @discardableResult
    public class func showGIFImage(data imageData: Data, status: String? = nil) -> PQHUD {
        if let image = PQGIFImage.image(withGIFData: imageData) {
            SVProgressHUD.show(image, status: status)
        }else{
            showError("Image is nil, can not show it").dismiss()
        }
        return shared
    }
    
    /// show GIF image from url, status default is nil
    ///
    /// - Parameters:
    ///   - urlStr: url string
    ///   - status: default is nil
    /// - Returns: QFHUD
    @discardableResult
    public class func showGIFImage(url urlStr: String, status: String? = nil) -> PQHUD {
        PQGIFImage.image(withGIFUrl: urlStr, and: { (image) in
            if let image = image {
                SVProgressHUD.show(image, status: status)
            }else{
                showError("Image is nil, can not show it").dismiss()
            }
            
        })
        return shared
    }
    
    /// 显示成功信息，会显示一个✅
    ///
    /// - Parameter status: 文字
    @discardableResult
    public class func showSuccess(_ status : String? = nil) -> PQHUD {
        SVProgressHUD.showSuccess(withStatus: status)
        return shared
    }
    
    /// 隐藏
    @discardableResult
    public class func dismiss(_ timeInterval: TimeInterval = PQHUD.dismissTimeInterval) -> PQHUD {
        SVProgressHUD.dismiss(withDelay: timeInterval)
        return shared
    }
    /// 隐藏
    @discardableResult
    public class func dismissNow() -> PQHUD {
        SVProgressHUD.dismiss(withDelay: 0)
        return shared
    }
    
    /// 隐藏之后如果需要处理，就调用这个方法
    ///
    /// - Parameter completion: 回调
    @discardableResult
    public class func dismissWithCompletion(completion : @escaping
        SVProgressHUDDismissCompletion) -> PQHUD {
        SVProgressHUD.dismiss(completion: completion)
        return shared
    }
    
    
    /// 设置消失时间，并且监听回调
    ///
    /// - Parameters:
    ///   - delay: 消失时间
    @discardableResult
    public class func dismissWithDelay(_ delay : TimeInterval, completion : @escaping SVProgressHUDDismissCompletion) -> PQHUD {
        SVProgressHUD.dismiss(withDelay: delay, completion: completion)
        return shared
    }
}

extension PQHUD  {
    
    var isVisible: Bool {
        return SVProgressHUD.isVisible()
    }
    
    /// 显示HUD
    @discardableResult
    public func show() -> PQHUD {
        return PQHUD.show()
    }
    
    /// 显示一段文字，带转圈动画
    ///
    /// - Parameter status: 文字
    @discardableResult
    public func show(_ status : String? = nil) -> PQHUD {
        return PQHUD.show(status)
    }
    
    /// 设置文字,带感叹号
    ///
    /// - Parameter info: 文字
    @discardableResult
    public func showInfo(_ info : String? = nil) -> PQHUD {
        return PQHUD.showInfo(info)
    }
    
    /// 显示一张图片
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - status: 文字
    @discardableResult
    public func showImage(_ image :UIImage , status : String? = nil) -> PQHUD {
        return PQHUD.showImage(image, status: status)
    }
    
    /// 显示错误信息，会显示一个x
    ///
    /// - Parameter status: 文字
    @discardableResult
    public func showError(_ status: String? = nil) -> PQHUD {
        return PQHUD.showError(status)
    }
    
    /// 显示进度
    ///
    /// - Parameter progress: 进度
    @discardableResult
    public func showProgress(_ progress : Float) -> PQHUD {
        return PQHUD.showProgress(progress)
    }
    
    
    /// show GIF image from image named, status default is nil
    ///
    /// - Parameters:
    ///   - imageNamed: named
    ///   - status: default is nil
    /// - Returns: QFHUD
    @discardableResult
    public func showGIFImage(named imageNamed: String, status: String? = nil) -> PQHUD {
        return PQHUD.showGIFImage(named: imageNamed, status: status)
    }
    
    /// show GIF image from data, status default is nil
    ///
    /// - Parameters:
    ///   - data: data
    ///   - status: default is nil
    /// - Returns: QFHUD
    @discardableResult
    public func showGIFImage(data imageData: Data, status: String? = nil ) -> PQHUD {
        return PQHUD.showGIFImage(data: imageData, status: status)
    }
    
    /// show GIF image from url, status default is nil
    ///
    /// - Parameters:
    ///   - urlStr: url string
    ///   - status: default is nil
    /// - Returns: QFHUD
    @discardableResult
    public func showGIFImage(url urlStr: String, status: String? = nil ) -> PQHUD {
         return PQHUD.showGIFImage(url: urlStr, status: status)
    }
    
    /// 显示成功信息，会显示一个✅
    ///
    /// - Parameter status: 文字
    @discardableResult
    public func showSuccess(_ status : String? = nil) -> PQHUD {
        return PQHUD.showSuccess(status)
    }
    
    /// 隐藏
    @discardableResult
    public func dismiss(_ timeInterval: TimeInterval = PQHUD.dismissTimeInterval) -> PQHUD {
        return PQHUD.dismiss(timeInterval)
    }
    
    /// 隐藏
    @discardableResult
    public func dismissNow() -> PQHUD {
        return PQHUD.dismissNow()
    }
    
    /// 隐藏之后如果需要处理，就调用这个方法
    ///
    /// - Parameter completion: 回调
    @discardableResult
    public func dismissWithCompletion(completion : @escaping
        SVProgressHUDDismissCompletion) -> PQHUD {
        return PQHUD.dismissWithCompletion(completion: completion)
    }
    
    
    /// 设置消失时间，并且监听回调
    ///
    /// - Parameters:
    ///   - delay: 消失时间
    @discardableResult
    public func dismissWithDelay(_ delay : TimeInterval, completion : @escaping SVProgressHUDDismissCompletion) -> PQHUD {
        return PQHUD.dismissWithDelay(delay, completion: completion)
    }
}

