import UIKit

public class UIViewControllerSpy: UIViewController {
    public enum Calls {
        public static let dismiss = "dismiss(animated:completion:)"
        public static let present = "present(_:animated:completion:)"
        public static let show = "show(_:sender:)"
    }

    public var receivedViewController: UIViewController?

    public var spyReporter = Spy()

    public override func show(_ vc: UIViewController, sender: Any?) {
        receivedViewController = vc
        spyReporter.addCallToHistory(call: #function, params: [vc, sender])
    }

    public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        receivedViewController = viewControllerToPresent
        spyReporter.addCallToHistory(call: #function, params: [viewControllerToPresent, flag])
    }

    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        spyReporter.addCallToHistory(call: #function, params: [flag, completion])
        completion?()
    }
}
