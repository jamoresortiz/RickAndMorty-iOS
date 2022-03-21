import UIKit

class CharacterListViewController: UIViewController {

    // Dependencies
    private let presenter: CharacterListPresenterInterface
    private let characterTableView: CharacterListTableViewController

    // Views
    private let activityIndicatorView: UIActivityIndicatorView
    private var placeholderView: PlaceholderView

    init(presenter: CharacterListPresenterInterface) {
        self.presenter = presenter
        self.characterTableView = CharacterListTableViewController(style: .grouped)
        self.activityIndicatorView = UIActivityIndicatorView(style: .large)
        self.placeholderView = PlaceholderView()
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewReady()
    }
}

extension CharacterListViewController: CharacterListViewInterface {

    func initialSetup(with viewData: CharacterListViewData) {
        title = viewData.title
        characterTableView.initialSetup(
            moreResultsButtonTitle: viewData.moreResultsButtonTitle,
            completion: { [weak self] result in
                switch result {
                case let .didSelect(character):
                    self?.presenter.didSelect(character: character)
                case let .didSelectFav(character):
                    self?.presenter.didSelectFav(character: character)
                case .tapMoreResults:
                    self?.presenter.moreResultsButtonPressed()
                }
            })
    }

    func fillTableView(with characterList: [Character], canLoadMoreData: Bool, needScrollToTop: Bool) {
        characterTableView.fill(
            with: characterList,
            canLoadMoreData: canLoadMoreData,
            needScrollToTop: needScrollToTop
        )
    }

    func fillTableView(with characterList: [Character]) {
        characterTableView.fill(with: characterList)
    }

    func toogleFavCharactersButton(dependingOf isFavsShown: Bool) {
        let buttonItem = UIBarButtonItem(
            image: isFavsShown ? UIImage(named: "ic_fav_filled") : UIImage(named: "ic_fav"),
            style: .done,
            target: self,
            action: #selector(favNavButtonPressed)
        )
        navigationItem.rightBarButtonItem = buttonItem
    }

    func showLoading() {
        view.isUserInteractionEnabled = false
        view.addAutolayoutView(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicatorView.startAnimating()
    }

    func hideLoading() {
        view.isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }

    func showErrorView() {
        characterTableView.tableView.isHidden = true
        placeholderView = PlaceholderView(
            title: "Error loading data",
            buttonTitle: "Retry",
            buttonActionHandler: { [weak self] in
                self?.placeholderViewRetry()
            }
        )
        showPlaceholder(placeholderView)
    }

    func showNoDataView() {
        characterTableView.tableView.isHidden = true
        placeholderView = PlaceholderView(title: "You don't have any favorite character")
        showPlaceholder(placeholderView)
    }

    func showErrorAlert() {
        let alert = UIAlertController(title: "Error loading data", message: "Try it later", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func hidePlaceholder() {
        placeholderView.removeFromSuperview()
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
            characterTableView.tableView.leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor),
            characterTableView.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            characterTableView.tableView.trailingAnchor.constraint(equalTo: safeAreaMargins.trailingAnchor)
        ])
    }

    func setupNavigationBar() {
        let buttonItem = UIBarButtonItem(
            image: UIImage(named: "ic_fav"),
            style: .done,
            target: self,
            action: #selector(favNavButtonPressed)
        )
        navigationItem.rightBarButtonItem = buttonItem
        navigationController?.navigationBar.tintColor = .systemYellow
    }

    @objc func favNavButtonPressed() {
        presenter.favNavButtonPressed()
    }

    func showPlaceholder(_ placeholder: PlaceholderView) {
        view.addAutolayoutView(placeholder)
        NSLayoutConstraint.activate([
            placeholder.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            placeholder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Style.Spacing.XL),
            placeholder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Style.Spacing.XL)
        ])
    }

    func placeholderViewRetry() {
        hidePlaceholder()
        presenter.retryButtonPressed()
    }
}
