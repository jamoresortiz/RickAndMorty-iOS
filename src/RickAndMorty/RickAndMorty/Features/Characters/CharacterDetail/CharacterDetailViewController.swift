import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController {

    // Dependencies
    private let presenter: CharacterDetailPresenterInterface?

    // Views
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
        label.font = UIFont.boldSystemFont(ofSize: 27.0)
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()

    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = Style.Spacing.M
        return stackView
    }()

    private let locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = Style.Spacing.XXS
        return stackView
    }()

    private let locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19.0)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .center
        return label
    }()

    private let speciesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = Style.Spacing.XXS
        return stackView
    }()

    private let speciesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19.0)
        label.textAlignment = .center
        return label
    }()

    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .center
        return label
    }()

    private let statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = Style.Spacing.XXS
        return stackView
    }()

    private let statusTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 19.0)
        label.textAlignment = .center
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textAlignment = .center
        return label
    }()

    private let favLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16.0)
        label.textAlignment = .center
        return label
    }()

    init(presenter: CharacterDetailPresenterInterface) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewReady()
    }
}

extension CharacterDetailViewController: CharacterDetailViewInterface {

    func initialSetup(with viewData: CharacterDetailViewData) {
        title = viewData.title
        characterImageView.kf.setImage(
            with: URL(string: viewData.imageURL),
            placeholder: UIImage(systemName: "face.smiling"),
            options: [
                .processor(RoundCornerImageProcessor(cornerRadius: 20))
            ]
        )
        nameLabel.text = viewData.name
        locationTitleLabel.text = viewData.locationTitle
        locationLabel.text = viewData.location
        speciesTitleLabel.text = viewData.speciesTitle
        speciesLabel.text = viewData.species
        statusTitleLabel.text = viewData.statusTitle
        statusLabel.text = viewData.status
        if let favText = viewData.favText {
            favLabel.text = favText
        }
    }
}

private extension CharacterDetailViewController {

    func setupView() {
        view.backgroundColor = .systemBackground
        view.addAutolayoutView(containerView)
        containerView.addAutolayoutView(
            characterImageView,
            nameLabel,
            infoStackView
        )
        infoStackView.addArrangedSubview(speciesStackView)
        infoStackView.addArrangedSubview(statusStackView)
        infoStackView.addArrangedSubview(locationStackView)
        infoStackView.addArrangedSubview(favLabel)
        locationStackView.addArrangedSubview(locationTitleLabel)
        locationStackView.addArrangedSubview(locationLabel)
        speciesStackView.addArrangedSubview(speciesTitleLabel)
        speciesStackView.addArrangedSubview(speciesLabel)
        statusStackView.addArrangedSubview(statusTitleLabel)
        statusStackView.addArrangedSubview(statusLabel)
        setupAutolayout()
        setupNavigationBar()
    }

    func setupAutolayout() {
        let imageSize: CGFloat = 256.0
        let safeAreaMargins = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeAreaMargins.topAnchor, constant: Style.Spacing.L),
            containerView.leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor, constant: Style.Spacing.XL),
            containerView.trailingAnchor.constraint(equalTo: safeAreaMargins.trailingAnchor, constant: -Style.Spacing.XL),
            characterImageView.heightAnchor.constraint(equalToConstant: imageSize),
            characterImageView.widthAnchor.constraint(equalToConstant: imageSize),
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Style.Spacing.L),
            characterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Style.Spacing.L),
            characterImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Style.Spacing.L),
            characterImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -Style.Spacing.M),
            nameLabel.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: infoStackView.topAnchor, constant: -Style.Spacing.XL),
            infoStackView.leadingAnchor.constraint(equalTo: characterImageView.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: characterImageView.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Style.Spacing.L)
        ])
    }

    func setupNavigationBar() {
        let buttonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(dismissModal)
        )
        navigationItem.leftBarButtonItem = buttonItem
        navigationController?.navigationBar.tintColor = .label
    }

    @objc func dismissModal() {
        presenter?.dismiss()
    }
}
