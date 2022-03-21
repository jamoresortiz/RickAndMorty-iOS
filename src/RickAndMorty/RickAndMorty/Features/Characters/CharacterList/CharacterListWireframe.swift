import UIKit

final class CharacterListWireframe {

    // Dependencies
    weak var view: UIViewController?
    private let characterDetailConfiguratorInterface: CharacterDetailConfiguratorInterface

    init(characterDetailConfiguratorInterface: CharacterDetailConfiguratorInterface) {
        self.characterDetailConfiguratorInterface = characterDetailConfiguratorInterface
    }
}

extension CharacterListWireframe: CharacterListWireframeInterface {

    func presentDetail(of character: Character) {
        guard
            let viewController = characterDetailConfiguratorInterface.prepareScene(with: character)
        else {
            assertionFailure("Error presenting detail view")
            return
        }
        let navController = UINavigationController(rootViewController: viewController)
        view?.present(navController, animated: true)
    }

    func presentFavCharacters() {
        // TODO 😖
    }
}
