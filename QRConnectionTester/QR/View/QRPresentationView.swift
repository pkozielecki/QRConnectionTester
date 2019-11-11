import Foundation
import UIKit

protocol QRPresentationViewDelegate: class {
    func viewDidFinish(_ view: QRPresentationView)
}

class QRPresentationView: UIView {

    @IBOutlet weak var imageView: UIImageView!

    weak var delegate: QRPresentationViewDelegate?

    @IBAction func didTapCloseButton(_ sender: Any) {
        delegate?.viewDidFinish(self)
    }

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        arrangeView()
    }
}

private extension QRPresentationView {

    func arrangeView() {
        //todo: arrange translations
        //todo: arrange subviews

        layoutIfNeeded()
    }
}
