@testable import RickAndMorty

final class CharacterListPresenterMock {

    let spy = Spy()
    weak var viewController: CharacterListViewInterface?

    enum Calls {

    }
}

extension CharacterListPresenterMock: CharacterListPresenterInterface {

    func viewReady() {
        let viewData = CharacterListViewData(
            title: "title",
            errorViewTitle: "errorViewTitle",
            errorViewButtonTitle: "errorViewButtonTitle",
            noDataViewTitle: "noDataViewTitle",
            errorAlertTitle: "errorAlertTitle",
            errorAlertDescription: "errorAlertDescription",
            errorAlertButtonTitle: "errorAlertButtonTitle",
            moreResultsButtonTitle: "moreResultsButtonTitle"
        )
        viewController?.initialSetup(with: viewData)
    }

    func retryButtonPressed() {
        spy.addCallToHistory(call: #function)
    }

    func didSelect(character: Character) {
        spy.addCallToHistory(call: #function, params: [character])
    }

    func didSelectFav(character: Character) {
        spy.addCallToHistory(call: #function, params: [character])
    }

    func moreResultsButtonPressed() {
        spy.addCallToHistory(call: #function)
    }

    func favNavButtonPressed() {
        spy.addCallToHistory(call: #function)
    }
}
