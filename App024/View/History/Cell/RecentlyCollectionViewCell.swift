//
//  RecentlyCollectionViewCell.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.01.25.
//

import UIKit
import SnapKit
import Combine

final class RecentlyCollectionViewCell: UICollectionViewCell, IReusableView {

    private var image = UIImageView()
    private let playImage = UIImageView()
    private let delete = UIButton(type: .system)

    public var deleteSubject = PassthroughSubject<Bool, Never>()
    var cancellables = Set<AnyCancellable>()

    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables.removeAll()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        makeButtonActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
        makeButtonActions()
    }

    private func setupUI() {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true

        self.delete.setImage(UIImage(named: "deleteBlack")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.delete.tintColor = .white

        self.addSubview(image)
        self.addSubview(playImage)
        self.addSubview(delete)
    }

    private func setupConstraints() {
        image.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }

        playImage.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.centerY.equalToSuperview()
            view.height.equalTo(48)
            view.width.equalTo(48)
        }

        delete.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.trailing.equalToSuperview().inset(8)
            view.height.equalTo(32)
            view.width.equalTo(32)
        }
    }

    public func setup(image: UIImage, isVideo: Bool = false) {
        self.image.image = image

        if isVideo {
            self.playImage.image = UIImage(named: "playIcon")
        }
    }
}

extension RecentlyCollectionViewCell {
    private func makeButtonActions() {
        self.delete.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    @objc func deleteButtonTapped() {
        self.deleteSubject.send(true)
    }
}
