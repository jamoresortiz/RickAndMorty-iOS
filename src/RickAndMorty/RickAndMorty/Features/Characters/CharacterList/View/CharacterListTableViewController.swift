import UIKit

class CharacterListTableViewController: UITableViewController {

    // Params
    private let characterCellId = "characterCellId"
    private var moreResultsButtonTitle: String?
    private var completion: ((CharacterListResult) -> Void)?
    private var characterList: [Character]
    private var canLoadMoreData: Bool

    override init(style: UITableView.Style) {
        characterList = [Character]()
        canLoadMoreData = true
        super.init(style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func initialSetup(moreResultsButtonTitle: String,
                      completion: @escaping (CharacterListResult) -> Void) {
        self.moreResultsButtonTitle = moreResultsButtonTitle
        self.completion = completion
    }

    func fill(with characterList: [Character], canLoadMoreData: Bool, needScrollToTop: Bool) {
        self.characterList = characterList
        self.canLoadMoreData = canLoadMoreData
        if needScrollToTop {
            tableView.setContentOffset(.zero, animated: false)
        }
        tableView.reloadData()
        tableView.isHidden = false
    }

    func fill(with characterList: [Character]) {
        self.characterList = characterList
        tableView.reloadData()
    }

}

extension CharacterListTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList.count
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        canLoadMoreData ? configureFooter() : UIView()
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        canLoadMoreData ? 50.0 : 0.0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let character = characterList[safe: indexPath.row]
        else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: characterCellId, for: indexPath) as? CharacterViewCell
        cell?.configure(
            imageURL: character.image,
            name: character.name,
            isFav: character.isFav,
            completion: { [weak self] in
                self?.completion?(
                    .didSelectFav(character: character)
                )
            }
        )
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let character = characterList[safe: indexPath.row]
        else {
            assertionFailure("Fail to select a character")
            return
        }
        completion?(
            .didSelect(character: character)
        )
    }
}

private extension CharacterListTableViewController {

    func setupView() {
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.register(CharacterViewCell.self, forCellReuseIdentifier: characterCellId)
    }

    func configureFooter() -> UIView {
        let footerView = UIView()
        let containerButtonView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 20
            view.backgroundColor = .secondarySystemGroupedBackground
            return view
        }()
        let footerButton: UIButton = {
            let button = UIButton()
            button.setTitle(self.moreResultsButtonTitle ?? "", for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            button.addTarget(self, action: #selector(moreResultsButtonPressed), for: .touchUpInside)
            return button
        }()

        footerView.addAutolayoutView(containerButtonView)
        containerButtonView.pinTo(
            view: footerView,
            top: Style.Spacing.XS,
            leading: Style.Spacing.XL,
            bottom: Style.Spacing.XS,
            trailing: Style.Spacing.XL
        )
        containerButtonView.addAutolayoutView(footerButton)
        footerButton.pinTo(view: containerButtonView)

        return footerView
    }

    @objc func moreResultsButtonPressed() {
        completion?(.tapMoreResults)
    }
}
