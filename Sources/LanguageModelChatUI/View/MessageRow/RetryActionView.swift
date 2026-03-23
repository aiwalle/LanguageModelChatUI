//
//  RetryActionView.swift
//  LanguageModelChatUI
//

import MarkdownView
import UIKit

final class RetryActionView: MessageListRowView {
    static let preferredHeight: CGFloat = 36

    var tapHandler: (() -> Void)?

    var buttonTitle: String = String.localized("Retry") {
        didSet { retryButton.setTitle(buttonTitle, for: .normal) }
    }

    private lazy var retryButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "arrow.clockwise")
        configuration.imagePadding = 6
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8)
        let button = UIButton(type: .system)
        button.configuration = configuration
        button.contentHorizontalAlignment = .leading
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(retryButton)
        updateButtonStyle()
        retryButton.setTitle(buttonTitle, for: .normal)
    }

    @available(*, unavailable)
    @MainActor required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var theme: MarkdownTheme {
        didSet { updateButtonStyle() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        retryButton.frame = contentView.bounds
    }

    @objc
    private func retryButtonTapped() {
        tapHandler?()
    }

    private func updateButtonStyle() {
        retryButton.tintColor = theme.colors.body
        retryButton.titleLabel?.font = theme.fonts.footnote
    }
}
