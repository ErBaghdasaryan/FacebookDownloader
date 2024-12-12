//
//  InstructionCell.swift
//  App024
//
//  Created by Er Baghdasaryan on 12.12.24.
//

import UIKit
import AppModel

final class InstructionCell: UITableViewCell, IReusableView {

    private let content = UIView()
    private let stepImage = UIImageView()
    private let phoneImage = UIImageView()
    private let header = UILabel(text: "",
                                       textColor: .black,
                                       font: UIFont(name: "SFProText-Bold", size: 22))
    private let subheader = UILabel(text: "",
                                textColor: .black.withAlphaComponent(0.8),
                                font: UIFont(name: "SFProText-Regular", size: 15))

    private func setupUI() {

        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.content.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        self.content.layer.cornerRadius = 28
        self.selectionStyle = .none

        self.header.textAlignment = .left
        self.subheader.textAlignment = .left

        self.phoneImage.layer.masksToBounds = true
        self.phoneImage.layer.cornerRadius = 16

        addSubview(content)
        content.addSubview(stepImage)
        content.addSubview(header)
        content.addSubview(subheader)
        content.addSubview(phoneImage)
        setupConstraints()
    }

    private func setupConstraints() {
        content.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(14)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview().inset(14)
        }

        stepImage.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(7)
            view.leading.equalToSuperview()
            view.width.equalTo(36)
            view.height.equalTo(36)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalTo(stepImage.snp.trailing).offset(14)
            view.trailing.equalToSuperview()
            view.height.equalTo(28)
        }

        subheader.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(2)
            view.leading.equalTo(stepImage.snp.trailing).offset(14)
            view.trailing.equalToSuperview()
            view.height.equalTo(20)
        }

        phoneImage.snp.makeConstraints { view in
            view.top.equalTo(subheader.snp.bottom).offset(16)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
    }

    public func setup(with model: InstructionPresentationModel) {
        self.stepImage.image = UIImage(named: model.stepImage)
        self.phoneImage.image = UIImage(named: model.phoneImage)
        self.header.text = model.header
        self.subheader.text = model.description

        self.setupUI()
    }
}
