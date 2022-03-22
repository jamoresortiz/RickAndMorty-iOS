import UIKit

public typealias TapActionHandler = () -> Void

final class PlaceholderView: UIView {

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = Style.Spacing.M

        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 21.0)
        label.numberOfLines = 3
        return label
    }()

    let containerButtonView = UIView()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        button.layer.cornerRadius = 10
        button.backgroundColor = .secondarySystemGroupedBackground
        return button
    }()

    private var actionButtonTapHandler: TapActionHandler?

    convenience init(title: String,
                     buttonTitle: String,
                     buttonActionHandler: @escaping TapActionHandler) {
        self.init(frame: .zero)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        actionButtonTapHandler = buttonActionHandler

        setup(title: title, needButton: true)
    }

    @objc func didTapActionButton() {
        actionButtonTapHandler?()
    }

    convenience init(title: String) {
        self.init(frame: .zero)
        setup(title: title, needButton: false)
    }
}

private extension PlaceholderView {

    private func setup(title: String, needButton: Bool) {
        titleLabel.text = title
        stackView.addArrangedSubview(titleLabel)

        if needButton {
            stackView.addArrangedSubview(containerButtonView)
            containerButtonView.addAutolayoutView(actionButton)
            NSLayoutConstraint.activate([
                actionButton.topAnchor.constraint(equalTo: containerButtonView.topAnchor),
                actionButton.bottomAnchor.constraint(equalTo: containerButtonView.bottomAnchor),
                actionButton.widthAnchor.constraint(equalToConstant: 100.0),
                actionButton.centerXAnchor.constraint(equalTo: containerButtonView.centerXAnchor),
                actionButton.centerYAnchor.constraint(equalTo: containerButtonView.centerYAnchor)
            ])
        }

        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
