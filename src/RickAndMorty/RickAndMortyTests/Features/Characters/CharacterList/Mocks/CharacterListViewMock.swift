@testable import RickAndMorty
import XCTest

final class CharacterListViewMock {

    let spy = Spy()

    enum Calls {
        static let initialSetup = "initialSetup(with:)"
        static let fillTableView = "fillTableView(with:canLoadMoreData:needScrollToTop:)"
        static let fillTableViewShort = "fillTableView(with:)"
        static let toogleFavCharactersButton = "toogleFavCharactersButton(dependingOf:)"
        static let showLoading = "showLoading()"
        static let hideLoading = "hideLoading()"
        static let showErrorView = "showErrorView()"
        static let showNoDataView = "showNoDataView()"
        static let showErrorAlert = "showErrorAlert()"
        static let hidePlaceholder = "hidePlaceholder()"
    }

    var fillTableViewExpectation: XCTestExpectation?
    var hideLoadingExpectation: XCTestExpectation?
    var showErrorViewExpectation: XCTestExpectation?
    var showNoDataViewExpectation: XCTestExpectation?
    var showErrorAlertExpectation: XCTestExpectation?
}

extension CharacterListViewMock: CharacterListViewInterface {

    func initialSetup(with viewData: CharacterListViewData) {
        spy.addCallToHistory(call: #function, params: [viewData])
    }

    func fillTableView(with characterList: [Character], canLoadMoreData: Bool, needScrollToTop: Bool) {
        spy.addCallToHistory(call: #function, params: [characterList, canLoadMoreData, needScrollToTop])
        fillTableViewExpectation?.fulfill()
    }

    func fillTableView(with characterList: [Character]) {
        spy.addCallToHistory(call: #function, params: [characterList])
    }

    func toogleFavCharactersButton(dependingOf isFavsShown: Bool) {
        spy.addCallToHistory(call: #function, params: [isFavsShown])
    }

    func showLoading() {
        spy.addCallToHistory(call: #function)
    }

    func hideLoading() {
        spy.addCallToHistory(call: #function)
        hideLoadingExpectation?.fulfill()
    }

    func showErrorView() {
        spy.addCallToHistory(call: #function)
        showErrorViewExpectation?.fulfill()
    }

    func showNoDataView() {
        spy.addCallToHistory(call: #function)
        showNoDataViewExpectation?.fulfill()
    }

    func showErrorAlert() {
        spy.addCallToHistory(call: #function)
        showErrorAlertExpectation?.fulfill()
    }

    func hidePlaceholder() {
        spy.addCallToHistory(call: #function)
    }
}
