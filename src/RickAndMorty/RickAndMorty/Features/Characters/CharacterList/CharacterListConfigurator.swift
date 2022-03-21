import UIKit

final class CharacterListConfigurator: CharacterListConfiguratorInterface {

    func prepareScene() -> UIViewController? {
        guard
            let charactersRepository = FeatureDependencies.shared.charactersRepository
        else {
            assertionFailure("Missing dependencies")
            return nil
        }

        let interactor = CharacterListInteractor(
            charactersRepository: charactersRepository,
            localProvider: LocalProvider(defaults: UserDefaults.standard)
        )
        let wireframe = CharacterListWireframe(
            characterDetailConfiguratorInterface: CharacterDetailConfigurator()
        )
        let presenter = CharacterListPresenter(
            wireframe: wireframe,
            interactor: interactor
        )
        let viewController = CharacterListViewController(presenter: presenter)
        presenter.view = viewController
        wireframe.view = viewController

        return viewController
    }
}
