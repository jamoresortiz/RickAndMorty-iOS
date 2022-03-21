final class CharacterDetailPresenter {

    // Dependencies
    weak var view: CharacterDetailViewInterface?
    private let wireframe: CharacterDetailWireframeInterface

    // Params
    private let character: Character?

    init(wireframe: CharacterDetailWireframeInterface,
         character: Character) {
        self.wireframe = wireframe
        self.character = character
    }
}

extension CharacterDetailPresenter: CharacterDetailPresenterInterface {

    func viewReady() {
        guard
            let character = self.character
        else {
            assertionFailure("Error getting the character")
            return
        }
        let viewData = CharacterDetailViewData(
            title: "Character Detail",
            imageURL: character.image,
            name: character.name,
            locationTitle: "Location",
            location: character.location.name,
            speciesTitle: "Species",
            species: character.species,
            statusTitle: "Status",
            status: character.status,
            favText: character.isFav ? "* Is one of your favorite characters *" : nil
        )
        view?.initialSetup(with: viewData)
    }

    func dismiss() {
        wireframe.dismiss()
    }
}
