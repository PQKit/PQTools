

import UIKit

public extension UITableView{
    convenience init(frame: CGRect = .zero,
                     delegate: UITableViewDelegate? = nil,
                     dataSource: UITableViewDataSource? = nil,
                     rowHeight: CGFloat = 44){
        self.init(frame: frame)
        self.delegate = delegate
        self.dataSource = dataSource
        self.rowHeight = rowHeight
    }
}
