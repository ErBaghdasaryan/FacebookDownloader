//
//  PublicationView.swift
//  App024
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import UIKit
import AVFoundation

class PublicationView: UIView, IReusableView {

    private let profileImage = UIImageView()
    private let name = UILabel(text: "",
                               textColor: .black,
                               font: UIFont(name: "SFProText-Semibold", size: 17))
    private let hour = UILabel(text: "",
                               textColor: .black,
                               font: UIFont(name: "SFProText-Regular", size: 12))
    private let descriptionLabel = UILabel(text: "",
                                           textColor: .black,
                                           font: UIFont(name: "SFProText-Regular", size: 13))
    private let post = PostView()

    public func setupUI() {

        self.profileImage.layer.masksToBounds = true
        self.profileImage.layer.cornerRadius = 75
        self.profileImage.contentMode = .scaleAspectFill

        self.name.textAlignment = .left
        self.hour.textAlignment = .left
        self.descriptionLabel.textAlignment = .left
        self.descriptionLabel.numberOfLines = 0

        addSubview(profileImage)
        addSubview(name)
        addSubview(hour)
        addSubview(descriptionLabel)
        addSubview(post)
        setupConstraints()
    }

    private func setupConstraints() {
        profileImage.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.height.equalTo(44)
            view.width.equalTo(44)
        }

        name.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalTo(profileImage.snp.trailing).offset(5)
            view.trailing.equalToSuperview()
            view.height.equalTo(25)
        }

        hour.snp.makeConstraints { view in
            view.top.equalTo(name.snp.bottom).offset(5.5)
            view.leading.equalTo(profileImage.snp.trailing).offset(5)
            view.trailing.equalToSuperview()
            view.height.equalTo(18)
        }

        descriptionLabel.snp.makeConstraints { view in
            view.top.equalTo(hour.snp.bottom).offset(8)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
        }

        post.snp.makeConstraints { view in
            view.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }
    }

    public func setup(profileImage: UIImage,
                      name: String,
                      hour: String,
                      description: String,
                      isVideo: Bool,
                      image: UIImage? = nil,
                      url: URL? = nil) {
        self.profileImage.image = profileImage
        self.name.text = name
        self.hour.text = hour
        self.descriptionLabel.text = description

        if isVideo {
            self.post.setupVideo(url: url!)
        } else {
            self.post.setup(image: image!)
        }
    }
}
