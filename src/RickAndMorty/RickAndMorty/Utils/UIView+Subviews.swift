import UIKit

extension UIView {

    func addAutolayoutView(_ views: UIView...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func pinTo(view parentView: UIView, top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) {
        let safeAreaMargins = parentView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: safeAreaMargins.topAnchor, constant: top),
            bottomAnchor.constraint(equalTo: safeAreaMargins.bottomAnchor, constant: -bottom),
            leadingAnchor.constraint(equalTo: safeAreaMargins.leadingAnchor, constant: leading),
            trailingAnchor.constraint(equalTo: safeAreaMargins.trailingAnchor, constant: -trailing)
        ])
    }
}
