
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
    convenience init(frame: CGRect = .zero,
                     textColor: UIColor = .black,
                     fontSize: CGFloat = 17,
                     textAlignment: NSTextAlignment = .left,
                     text: String? = nil) {
        self.init(frame: frame)
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize)
        self.textAlignment = textAlignment
        self.text = text
    }
}
