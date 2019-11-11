import UIKit

class ViewController: UIViewController {

    var qrGenerator: QRGenerator = DefaultQRGenerator()
    var ipAddressProvider: IPAddressProvider = DefaultIPAddressProvider()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapHostButton(_ sender: Any) {
        let ipAddress = ipAddressProvider.getIPAddress(for: .wifi) ?? ""
        qrGenerator.generateQR(fromData: ipAddress.data) {
            [weak self] image in
            if let image = image {
                self?.show(qr: image)
            }

            //todo: handle error
        }
    }

    @IBAction func didTapPeerButton(_ sender: Any) {
        let acquisitionViewController = QRAcquisitionViewController()
        acquisitionViewController.delegate = self
        navigationController?.present(acquisitionViewController, animated: true)
    }
}

extension ViewController: QRAcquisitionViewControllerDelegate {
    func viewControllerDidCancel(_ viewController: QRAcquisitionViewController) {
        dismissCurrentPopup()
    }

    func viewController(_ viewController: QRAcquisitionViewController, didFinishWithCode code: String) {
        navigationController?.dismiss(animated: true) {
            [weak self] in
            let alert = UIAlertController(title: "Found code", message: code, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .cancel))
            self?.navigationController?.present(alert, animated: true)
        }
    }
}

extension ViewController: QRPresentationViewControllerDelegate {

    func viewControllerDidFinish(_ controller: QRPresentationViewController) {
        dismissCurrentPopup()
    }
}

private extension ViewController {

    func show(qr image: UIImage) {
        // todo: move to navigation flow coordinator
        let previewViewController = QRPresentationViewController(image: image)
        previewViewController.delegate = self
        navigationController?.present(previewViewController, animated: true)
    }

    func dismissCurrentPopup() -> Void {
        // todo: move to navigation flow coordinator
        navigationController?.dismiss(animated: true)
    }
}

