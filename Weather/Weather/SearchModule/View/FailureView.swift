//
//  FailureView.swift
//  Weather
//
//  Created by Mohamed Fawzy on 22/09/2024.
//

import UIKit

final class FailureView: UIView {
    private let vStack = UIStackView()
    private let messageLabel = UILabel()
    private let button = UIButton()
    private let onTap: () -> Void
    
    init(buttonTitle: String, onTap: @escaping () -> Void) {
        self.onTap = onTap
        super.init(frame: .zero)
        setupView(buttonTitle: buttonTitle)
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(message: String) {
        messageLabel.text = message
        isHidden = false
    }
    
    func hideView() {
        isHidden = true
        messageLabel.text = nil
    }
    
    private func setupView(buttonTitle: String) {
        messageLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemBlue.withAlphaComponent(0.6), for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 26, weight: .bold)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        vStack.axis = .vertical
        vStack.spacing = 8
        [messageLabel, button].forEach {
            vStack.addArrangedSubview($0)
        }
        addSubview(vStack)
        hideView()
    }
    
    private func setupConstrains() {
        vStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    @objc func didTapButton() {
        onTap()
    }
}
