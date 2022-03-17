//
//  CharacterListTableViewController.swift
//  RickAndMorty
//
//  Created by Jorge Amores on 17/3/22.
//

import UIKit

class CharacterListTableViewController: UITableViewController {

    private let characterCellId = "characterCellId"
    weak var rootViewController: CharacterListViewInterface?
    private var characterList: [Character]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

extension CharacterListTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterList?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let character = characterList?[indexPath.row]
        else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: characterCellId, for: indexPath) as? CharacterViewCell
        return cell ?? UITableViewCell()
    }
}

private extension CharacterListTableViewController {

    func setupView() {
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(<#T##nib: UINib?##UINib?#>, forCellReuseIdentifier: characterCellId)
    }
}
