//
//  SectionHeaderView.swift
//  App024
//
//  Created by Er Baghdasaryan on 13.12.24.
//

import UIKit
import SnapKit
import AppModel
import Combine

final class SectionHeaderView: UITableViewHeaderFooterView, IReusableView {

    private let titleLabel = UILabel(text: "",
                                     textColor: .black,
                                     font: UIFont(name: "SFProText-Bold", size: 13))

    private func setupUI() {
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { view in
            view.top.equalTo(contentView.snp.top)
            view.leading.equalTo(contentView.snp.leading)
        }
    }

    public func setup(with title: String) {
        self.titleLabel.text = title

        self.setupUI()
    }
}
