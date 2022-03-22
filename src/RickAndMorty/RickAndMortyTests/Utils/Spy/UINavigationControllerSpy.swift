import UIKit

public class UINavigationControllerSpy: UINavigationController {

    public enum Calls {
        public static let pop = "popViewController(animated:)"
        public static let dismiss = "dismiss(animated:completion:)"
        public static let push = "pushViewController(_:animated:)"
        public static let show = "show(_:sender:)"
        public static let popToRootViewController = "popToRootViewController(animated:)"
        public static let popToViewController = "popToViewController(_:animated:)"
        public static let setViewControllers = "setViewControllers(_:animated:)"
    }

    public var spyReporter = Spy()

    public override func popViewController(animated: Bool) -> UIViewController? {
        spyReporter.addCallToHistory(call: #function, params: [animated])
        return nil
    }

    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        spyReporter.addCallToHistory(call: #function, params: [flag, completion])
    }

    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        spyReporter.addCallToHistory(call: #function, params: [viewController])
    }

    // swiftlint:disable:next identifier_name
    public override func show(_ vc: UIViewController, sender: Any?) {
        super.show(vc, sender: sender)
        spyReporter.addCallToHistory(call: #function, params: [vc, sender])
    }

    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        spyReporter.addCallToHistory(call: #function, params: [animated])
        return nil
    }

    public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        spyReporter.addCallToHistory(call: #function, params: [viewController, animated])
        return nil
    }

    public override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        spyReporter.addCallToHistory(call: #function, params: [viewControllers, animated])
    }
}
