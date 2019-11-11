import Foundation
import UIKit
import SnapKit

protocol QRAcquisitionViewDelegate: class {
    func viewDidCancel(_ view: QRAcquisitionView)
    func view(_ view: QRAcquisitionView, didFinishWithCode code: String)
}

class QRAcquisitionView: UIView {

    weak var delegate: QRAcquisitionViewDelegate?

    @IBOutlet weak var scannerView: QRScannerView!

    @IBAction func didTapClosButton(_ sender: Any) {
        delegate?.viewDidCancel(self)
    }

    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow != nil {
            arrangeView()
            scannerView.startScanning()
        } else {
            scannerView.stopScanning()
        }
    }
}

extension QRAcquisitionView: QRScannerViewDelegate {

    func qrScanningDidFail() {
    }

    func qrScanningSucceededWithCode(_ str: String?) {
        if let code = str {
            delegate?.view(self, didFinishWithCode: code)
        }
    }

    func qrScanningDidStop() {
    }
}

private extension QRAcquisitionView {

    func arrangeView() {
        scannerView.delegate = self
        layoutIfNeeded()
    }
}
