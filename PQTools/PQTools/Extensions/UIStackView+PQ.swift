

import UIKit

// MARK: UIStackView
public extension UIStackView{
    
    /// fast init UIStackView
    ///
    /// - Parameters:
    ///   - frame: default is nil
    ///   - axis: NSLayoutConstraint.Axis
    ///   - alignment: UIStackView.Alignment
    ///   - distribution: UIStackView.Distribution
    convenience init(frame: CGRect = .zero,
                     axis: NSLayoutConstraint.Axis,
                     alignment: UIStackView.Alignment,
                     distribution: UIStackView.Distribution){
        self.init(frame: frame)
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
    }
}
