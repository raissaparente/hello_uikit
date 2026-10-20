import UIKit

class ColorRectangleViewController: UIViewController {

    private let colorView: UIView = {
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
        view.addSubview(colorView)
        view.addSubview(colorButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            colorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: colorButton.topAnchor),

            colorButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            colorButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            colorButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func setupActions() {
        colorButton.addTarget(self, action: #selector(changeColorToGreen), for: .touchUpInside)
    }

    @objc private func changeColorToGreen() {
        colorView.backgroundColor = .green
    }
}
