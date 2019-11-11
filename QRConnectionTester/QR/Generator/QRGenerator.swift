import Foundation
import UIKit
import QRSwift

protocol QRGenerator {

    func generateQR(fromData data: Data, completion: @escaping (UIImage?) -> Void)
}

class DefaultQRGenerator: QRGenerator {
    let standardQRCodeSize = CGSize(width: 1024, height: 1024)

    var backgroundQueueExecutor: OperationsExecutor = BackgroundQueueOperationsExecutor()
    var mainQueueExecutor: OperationsExecutor = MainQueueOperationsExecutor()
    var generator: QRCodeGeneratorWrapper

    init() {
        generator = QRCodeGenerator()
        generator.correctionLevel = .M
    }

    func generateQR(fromData data: Data, completion: @escaping (UIImage?) -> Void) {
        let size = standardQRCodeSize
        backgroundQueueExecutor.execute {
            [weak self] in
            let image = self?.generator.image(with: data, codeImageSize: size)
            self?.mainQueueExecutor.execute {
                if let image = image {
                    let uiimage = UIImage(ciImage: image)
                    completion(uiimage)
                } else {
                    completion(nil)
                }
            }
        }
    }
}

protocol QRCodeGeneratorWrapper {
    var correctionLevel: QRCodeGenerator.CorrectionLevel { get set }
    func image(with data: Data, codeImageSize size: CGSize) -> CIImage?
}

extension QRCodeGenerator: QRCodeGeneratorWrapper {

    func image(with data: Data, codeImageSize size: CGSize) -> CIImage? {
        self.image(with: data, outputImageSize: size)
    }
}
