import UIKit

class CharacterListViewController: UIViewController {

    // Dependencies
    private let presenter: CharacterListPresenterInterface
    private let characterTableView = CharacterListTableViewController(style: .grouped)

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
        presenter.viewReady()
        setupView()
    }
}

extension CharacterListViewController: CharacterListViewInterface {

    func set(title: String) {
        self.title = title
    }

    func configureTableView(characterListViewData: [CharacterViewData]) {
        characterTableView.rootViewController = self
        characterTableView.configure(characterListViewData: characterListViewData)
    }

    func didSelect(at row: Int) {
        presenter.didSelect(at: row)
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
        view.addAutolayoutView(characterTableView.tableView)
        setupAutolayout()
        setupNavigationBar()
    }

    func setupAutolayout() {
        let safeAreaMargins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            characterTableView.tableView.topAnchor.constraint(equalTo: safeAreaMargins.topAnchor),
            characterTableView.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterTableView.tableView.leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor),
            characterTableView.tableView.trailingAnchor.constraint(equalTo: safeAreaMargins.trailingAnchor)
        ])
    }

    func setupNavigationBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)

        let navItem = UINavigationItem()
        navBar.setItems([navItem], animated: false)
    }
}
