import Foundation
import UIKit

final class CharacterListConfigurator {

    static func prepareScene() -> UIViewController? {
        guard
            let charactersRepository = FeatureDependencies.shared.charactersRepository
        else {
            assertionFailure("Missing dependencies")
            return nil
        }

        let interactor = CharacterListInteractor(
            charactersRepository: charactersRepository
        )
        let wireframe = CharacterListWireframe()
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
