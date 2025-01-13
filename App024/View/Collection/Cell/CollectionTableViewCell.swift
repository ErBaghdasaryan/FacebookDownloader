//
//  CollectionTableViewCell.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.01.25.
//

import UIKit
import SnapKit
import AppViewModel
import AppModel
import Combine

final class CollectionTableViewCell: UITableViewCell, IReusableView {

    private let subheader = UILabel(text: "",
                                    textColor: UIColor.black.withAlphaComponent(0.6),
                               font: UIFont(name: "SFProText-Regular", size: 12))
    private let header = UILabel(text: "",
                                 textColor: UIColor.black,
                                 font: UIFont(name: "SFProText-Regular", size: 16))
    private let image = UIImageView(image: UIImage(named: "folder"))

    private func setupUI() {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator

        self.subheader.textAlignment = .left
        self.header.textAlignment = .left

        addSubview(image)
        addSubview(header)
        addSubview(subheader)
        setupConstraints()
    }

    private func setupConstraints() {

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.leading.equalToSuperview()
            view.width.equalTo(52)
            view.height.equalTo(52)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(14)
            view.leading.equalTo(image.snp.trailing).offset(12)
            view.trailing.equalToSuperview().inset(44)
            view.height.equalTo(21)
        }

        subheader.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(2)
            view.leading.equalTo(image.snp.trailing).offset(12)
            view.trailing.equalToSuperview().inset(44)
            view.height.equalTo(16)
        }
    }

    public func setup(name: String, mediaCount: Int) {
        self.subheader.text = "Media: \(mediaCount)"
        self.header.text = name

        self.setupUI()
    }
}
