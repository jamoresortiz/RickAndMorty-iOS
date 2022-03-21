import UIKit

protocol CharacterDetailConfiguratorInterface {
    func prepareScene(with character: Character) -> UIViewController?
}

protocol CharacterDetailViewInterface: AnyObject {
    func initialSetup(with viewData: CharacterDetailViewData)
}

protocol CharacterDetailPresenterInterface {
    func viewReady()
    func dismiss()
}

protocol CharacterDetailWireframeInterface {
    func dismiss()
}
