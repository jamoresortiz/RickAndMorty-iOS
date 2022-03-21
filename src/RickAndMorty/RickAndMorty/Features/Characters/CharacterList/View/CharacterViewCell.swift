import UIKit
import Kingfisher

class CharacterViewCell: UITableViewCell {

    // Params
    private var completion: (() -> Void)?

    // Views

    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemGroupedBackground
        return view
    }()

    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.numberOfLines = 3
        return label
    }()

    private let favButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(named: "ic_fav"),
            for: .normal
        )
        button.tintColor = .systemYellow
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(imageURL: String,
                   name: String,
                   isFav: Bool,
                   completion: @escaping () -> Void) {
        self.completion = completion
        self.nameLabel.text = name
        self.characterImageView.kf.setImage(
            with: URL(string: imageURL),
            placeholder: UIImage(systemName: "face.smiling"),
            options: [
                .processor(RoundCornerImageProcessor(cornerRadius: 20))
            ]
        )
        self.favButton.setImage(
            UIImage(named: isFav ? "ic_fav_filled" : "ic_fav"),
            for: .normal
        )
    }

}

private extension CharacterViewCell {

    func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        favButton.addTarget(self, action: #selector(didTapFavButton), for: .touchUpInside)
        containerView.addAutolayoutView(
            characterImageView,
            nameLabel,
            favButton
        )
        contentView.addAutolayoutView(containerView)
        setupAutolayout()
    }

    func setupAutolayout() {
        let imageSize: CGFloat = 64.0
        let iconSize: CGFloat = 24.0

        containerView.pinTo(
            view: contentView,
            top: .zero,
            leading: Style.Spacing.M,
            bottom: Style.Spacing.XS,
            trailing: Style.Spacing.M
        )

        NSLayoutConstraint.activate([
            characterImageView.heightAnchor.constraint(equalToConstant: imageSize),
            characterImageView.widthAnchor.constraint(equalToConstant: imageSize),
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Style.Spacing.S),
            characterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Style.Spacing.S),
            characterImageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -Style.Spacing.L),
            characterImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Style.Spacing.S),
            nameLabel.topAnchor.constraint(equalTo: characterImageView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: favButton.leadingAnchor, constant: -Style.Spacing.L),
            favButton.widthAnchor.constraint(equalToConstant: iconSize),
            favButton.topAnchor.constraint(equalTo: characterImageView.topAnchor),
            favButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Style.Spacing.L),
            favButton.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor)
        ])
    }

    @objc func didTapFavButton() {
        self.completion?()
    }

    func configureFavIcon(isFav: Bool) {
        favButton.setImage(
            UIImage(named: isFav ? "ic_fav_filled" : "ic_fav"),
            for: .normal
        )
    }
}
