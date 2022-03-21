import UIKit

final class CharacterDetailWireframe: CharacterDetailWireframeInterface {

    weak var view: UIViewController?

    func dismiss() {
        view?.dismiss(animated: true)
    }
}
