
import UIKit


public extension UISlider{
    
    /// fast init slider
    ///
    /// - Parameters:
    ///   - frame: default is zero
    ///   - target: default is nil
    ///   - selector: default is nil
    convenience init(frame: CGRect = .zero,
                     target: Any? = nil,
                     selector: Selector? = nil){
        self.init(frame: frame)
        if  let target = target,
            let selector = selector {
            addTarget(target, action: selector, for: .valueChanged)
        }
    }
}
