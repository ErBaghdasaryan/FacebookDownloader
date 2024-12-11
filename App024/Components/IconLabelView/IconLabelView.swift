//
//  IconLabelView.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import SnapKit

class IconLabelView: UIView {

    private let imageView = UIImageView()
    private var label: UILabel!

    init(image: UIImage, text: String, textHeight: Int, imageSize: CGSize, spacing: Int = 0) {
        super.init(frame: .zero)
        setupView(image: image, text: text, textHeight: textHeight, imageSize: imageSize, spacing: spacing)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupView(image: UIImage, text: String, textHeight: Int, imageSize: CGSize, spacing: Int = 0) {
        imageView.image = image
        imageView.contentMode = .scaleAspectFit

        label = UILabel(text: text,
                        textColor: .black.withAlphaComponent(0.6),
                        font: UIFont(name: "SFProText-Regular", size: CGFloat(textHeight)))
        self.label.textAlignment = .left

        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .horizontal
        stackView.spacing = CGFloat(spacing)
        stackView.alignment = .center

        self.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(imageSize.height)
        }
    }
}
