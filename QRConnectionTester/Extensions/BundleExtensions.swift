import Foundation
import UIKit

extension Bundle {

    static func loadView<T: UIView>(fromNib name: String) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }

        fatalError("Could not load view from XIB: \(name)")
    }
}
