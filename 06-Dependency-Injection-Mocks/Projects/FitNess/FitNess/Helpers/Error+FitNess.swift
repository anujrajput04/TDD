import Foundation
import CoreMotion

extension Error {
    func `is`(_ type: CMError) -> Bool {
        let nsError = self as NSError
        return nsError.domain == CMErrorDomain &&
        nsError.code == type.rawValue
    }
}
