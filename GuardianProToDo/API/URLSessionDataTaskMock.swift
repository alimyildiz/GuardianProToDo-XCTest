import Foundation

class URLSessionDataTaskMock : URLSessionDataTask {
    
    private let taskAction: () -> Void
    
    init(taskAction: @escaping () -> Void) {
        self.taskAction = taskAction
    }
    
    override func resume() {
        
        DispatchQueue.main.async {
            self.taskAction()
            }
    }
}
