import UIKit

class CharacterListTableViewController: UITableViewController {

    // Dependencies
    weak var rootViewController: CharacterListViewInterface?

    // Params
    private let characterCellId = "characterCellId"
    private var characterListViewData = [CharacterViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func configure(characterListViewData: [CharacterViewData]) {
        self.characterListViewData = characterListViewData
        tableView.reloadData()
    }

}

extension CharacterListTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterListViewData.count
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let character = characterListViewData[safe: indexPath.row]
        else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: characterCellId, for: indexPath) as? CharacterViewCell
        cell?.configure(
            imageURL: character.imageURL,
            name: character.name
        )
        return cell ?? UITableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rootViewController?.didSelect(at: indexPath.row)
    }
}

private extension CharacterListTableViewController {

    func setupView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(CharacterViewCell.self, forCellReuseIdentifier: characterCellId)
    }
}
