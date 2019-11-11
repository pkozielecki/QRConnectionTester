import Foundation

enum AsynchronousExecutorType {
    case main
    case background
}

protocol OperationsExecutor {

    var queue: OperationQueue? { get }
    var type: AsynchronousExecutorType { get }

    func execute(_ block: @escaping () -> Void)
}

extension OperationsExecutor {

    func execute(_ block: @escaping () -> Void) {
        queue?.addOperation {
            block()
        }
    }
}

class MainQueueOperationsExecutor: OperationsExecutor {

    let queue: OperationQueue? = OperationQueue.main
    let type: AsynchronousExecutorType = .main
}

class BackgroundQueueOperationsExecutor: OperationsExecutor {

    let queue: OperationQueue?
    let type: AsynchronousExecutorType

    init() {
        self.queue = OperationQueue()
        self.type = .background
    }
}
