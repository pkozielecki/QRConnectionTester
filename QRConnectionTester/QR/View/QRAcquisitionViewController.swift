import Foundation
import UIKit

protocol QRAcquisitionViewControllerDelegate: class {
    func viewControllerDidCancel(_ viewController: QRAcquisitionViewController)
    func viewController(_ viewController: QRAcquisitionViewController, didFinishWithCode code: String)
}

class QRAcquisitionViewController: UIViewController {

    weak var delegate: QRAcquisitionViewControllerDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Init(coder) not implemented")
    }

    override func loadView() {
        let view: QRAcquisitionView = Bundle.loadView(fromNib: "QRAcquisitionView")
        view.delegate = self
        self.view = view
    }
}

extension QRAcquisitionViewController: QRAcquisitionViewDelegate {

    func viewDidCancel(_ view: QRAcquisitionView) {
        delegate?.viewControllerDidCancel(self)
    }

    func view(_ view: QRAcquisitionView, didFinishWithCode code: String) {
        delegate?.viewController(self, didFinishWithCode: code)
    }
}
