import UIKit

class CharacterListViewController: UIViewController {

    private let presenter: CharacterListPresenterInterface

    init(presenter: CharacterListPresenterInterface) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        // TODO 😖
        setupView()
        presenter.viewReady()
    }

}

extension CharacterListViewController: CharacterListViewInterface {

    func didSelect(character: Character) {
        presenter.didSelect(character)
    }


    func showLoading() {
        // TODO 😖
    }

    func hideLoading() {
        // TODO 😖
    }

    func showNoDataView() {
        // TODO 😖
    }
}

private extension CharacterListViewController {

    func setupView() {
        // TODO 😖
    }
}
