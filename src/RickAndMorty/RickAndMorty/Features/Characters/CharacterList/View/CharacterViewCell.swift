import UIKit

class CharacterViewCell: UITableViewCell {

    // Views
    private let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 2
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(imageURL: String, name: String) {
        // TODO Image 😖
        self.nameLabel.text = name
    }

}

private extension CharacterViewCell {

    func setupView() {
        self.selectionStyle = .none
        containerView.addAutolayoutView(nameLabel)
        contentView.addAutolayoutView(containerView)
        setupAutolayout()
    }

    func setupAutolayout() {
        nameLabel.pinTo(view: containerView)
        containerView.pinTo(
            view: contentView,
            top: 8,
            leading: 8,
            bottom: 8,
            trailing: 8
        )
    }

    func getImage(from stringURL: String) -> UIImage? {
        return UIImage()
    }
}
