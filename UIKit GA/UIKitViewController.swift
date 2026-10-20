import UIKit

class UIKitViewController: UIViewController {

    private let rectangleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let colorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Color Rectangle", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
        setupActions()
    }

    private func setupViews() {
        view.addSubview(rectangleView)
        view.addSubview(colorButton)
    }

    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            rectangleView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            rectangleView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            rectangleView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            rectangleView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),

            colorButton.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor),
            colorButton.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor)
        ])
    }

    private func setupActions() {
        colorButton.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
    }

    @objc private func colorButtonTapped() {
        rectangleView.backgroundColor = .green
    }
}

#Preview {
    UIKitViewController()
}
