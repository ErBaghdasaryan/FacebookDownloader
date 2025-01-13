//
//  EmptyTableViewCell.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.01.25.
//

import UIKit
import SnapKit

final class EmptyTableViewCell: UITableViewCell, IReusableView {

    private let header = UILabel(text: "Click on the folder at the top right",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Regular", size: 24))
    private var image = UIImageView(image: .init(named: "emptyImage"))

    public func setupUI() {
        self.header.numberOfLines = 2

        self.addSubview(image)
        self.addSubview(header)

        setupConstraints()
    }

    private func setupConstraints() {
        image.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.centerX.equalToSuperview()
            view.height.equalTo(256)
            view.width.equalTo(256)
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(image.snp.bottom)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
    }
}
