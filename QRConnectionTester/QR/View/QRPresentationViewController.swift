import Foundation
import UIKit

protocol QRPresentationViewControllerDelegate: class {
    func viewControllerDidFinish(_ controller: QRPresentationViewController)
}

class QRPresentationViewController: UIViewController {

    let image: UIImage
    weak var delegate: QRPresentationViewControllerDelegate?

    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder) not implemented")
    }

    override func loadView() {
        let view: QRPresentationView = Bundle.loadView(fromNib: "QRPresentationView")
        view.delegate = self
        view.imageView.image = image
        self.view = view
    }
}

extension QRPresentationViewController: QRPresentationViewDelegate {

    func viewDidFinish(_ view: QRPresentationView) {
        delegate?.viewControllerDidFinish(self)
    }
}
