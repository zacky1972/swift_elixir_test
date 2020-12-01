#if EXIST_FOUNDATION
import Foundation
#endif

@objc class ExampleClass: NSObject {
    var count = 0
    @objc func increment() {
        count += 1
#if WORK_NSLOG
        NSLog("Hello world from Swift.")
#endif
    }
    @objc func increment(by amount: Int) {
        count += amount
    }
    @objc func reset() {
        count = 0
    }
}
