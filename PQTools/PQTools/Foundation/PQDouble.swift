
import Foundation


public extension Reactive where Base == Double {
    
    /// cn:把Double转化为摄氏度
    /// en:Double to Celcius
    ///
    /// - Returns: 摄氏度数据
    func toCelcius() -> Double {
        return (pq - 32.0) / 1.8
    }
    
    
}
