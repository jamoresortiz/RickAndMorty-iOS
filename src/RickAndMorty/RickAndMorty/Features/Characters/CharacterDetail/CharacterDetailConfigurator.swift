import UIKit

final class CharacterDetailConfigurator: CharacterDetailConfiguratorInterface {

    func prepareScene(with character: Character) -> UIViewController? {
        let wireframe = CharacterDetailWireframe()
        let presenter = CharacterDetailPresenter(
            wireframe: wireframe,
            character: character
        )
        let viewController = CharacterDetailViewController(presenter: presenter)
        presenter.view = viewController
        wireframe.view = viewController

        return viewController
    }
}
