
import UIKit

// MARK: UILabel
public extension  UILabel {
    
    /// fast init label
    ///
    /// - Parameters:
    ///   - frame: frame default is zero
    ///   - textColor: color default is black
    ///   - fontSize: font size default is 17
    ///   - textAlignment: textAlignment default is left
    ///   - text: text default is nil
    class func pq_init(frame: CGRect = .zero,
                     textColor: UIColor = .black,
                     fontSize: CGFloat = 17,
                     textAlignment: NSTextAlignment = .left,
                     text: String? = nil) -> UILabel {
        let label = UILabel(frame: frame)
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize:  fontSize)
        label.textAlignment = textAlignment
        label.text = text
        return label
    }
}
