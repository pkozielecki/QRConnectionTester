import Foundation

extension String {

    var data: Data {
        data(using: .utf8) ?? Data()
    }
}
