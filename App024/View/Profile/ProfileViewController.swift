//
//  ProfileViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import UIKit
import AppViewModel
import SnapKit
import SDWebImage

final class ProfileViewController: BaseViewController {

    var viewModel: ViewModel?

    private let coverImage = UIImageView()
    private let pageImage = UIImageView()
    private let name = UILabel(text: "",
                               textColor: .black,
                               font: UIFont(name: "SFProText-Bold", size: 20))
    private let likes = UILabel(text: "",
                                textColor: .black,
                                font: UIFont(name: "SFProText-Semibold", size: 14))
    private let followers = UILabel(text: "",
                                    textColor: .black,
                                    font: UIFont(name: "SFProText-Semibold", size: 14))
    private let intro = UILabel(text: "",
                                textColor: .black,
                                font: UIFont(name: "SFProText-Semibold", size: 14))
    private let information = UILabel(text: "Information",
                                      textColor: .black,
                                      font: UIFont(name: "SFProText-Bold", size: 16))
    private let info = UILabel(text: "",
                               textColor: .black,
                               font: UIFont(name: "SFProText-Regular", size: 14))

    private let lastPublication = PublicationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white

        self.title = "Profile"
        self.navigationController?.navigationBar.tintColor = .black

        self.name.textAlignment = .left
        self.likes.textAlignment = .left
        self.followers.textAlignment = .left
        self.intro.textAlignment = .left
        self.intro.numberOfLines = 0
        self.information.textAlignment = .left
        self.info.textAlignment = .left
        self.info.numberOfLines = 0

        self.pageImage.layer.masksToBounds = true
        self.pageImage.layer.cornerRadius = 75
        self.pageImage.contentMode = .scaleAspectFill
        self.pageImage.layer.borderWidth = 3
        self.pageImage.layer.borderColor = UIColor.white.cgColor

        self.view.addSubview(coverImage)
        self.view.addSubview(pageImage)
        self.view.addSubview(name)
        self.view.addSubview(likes)
        self.view.addSubview(followers)
        self.view.addSubview(intro)
        self.view.addSubview(information)
        self.view.addSubview(info)
        self.view.addSubview(lastPublication)
        setupConstraints()
        setupNavigationBar()
    }

    override func setupViewModel() {
        super.setupViewModel()

        guard let profile = self.viewModel?.profile else  { return }

        self.name.text = profile.model.name
        self.likes.text = "\(profile.model.likesCount) likes"
        self.followers.text = "\(profile.model.followersCount) followers"
        self.intro.text = profile.model.introText
        let about = profile.model.about
        let sortedKeys = about.keys.sorted { $0 < $1 }

        let aboutText = sortedKeys.compactMap { "-\(about[$0] ?? "")" }.joined(separator: "\n")
        self.info.text = aboutText

        let coverURL = profile.model.coverImage
        self.fetchImageUsingSDWebImage(from: coverURL) { image in
            if let image = image {
                self.coverImage.image = image
            } else {
                print("Failed to fetch image")
            }
        }

        let profileImageURL = profile.model.pageImage
        self.fetchImageUsingSDWebImage(from: profileImageURL) { image in
            if let image = image {
                self.pageImage.image = image
            } else {
                print("Failed to fetch image")
            }
        }
    }

    func setupConstraints() {
        coverImage.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(110)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(212)
        }

        pageImage.snp.makeConstraints { view in
            view.top.equalTo(coverImage.snp.top).offset(132)
            view.leading.equalToSuperview().offset(9)
            view.width.equalTo(154)
            view.height.equalTo(154)
        }

        name.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(409)
            view.leading.equalToSuperview().offset(12)
            view.trailing.equalToSuperview().inset(12)
            view.height.equalTo(25)
        }

        likes.snp.makeConstraints { view in
            view.top.equalTo(name.snp.bottom).offset(5.5)
            view.leading.equalToSuperview().offset(12)
            view.trailing.equalToSuperview().inset(12)
            view.height.equalTo(18)
        }

        followers.snp.makeConstraints { view in
            view.top.equalTo(likes.snp.bottom).offset(5.5)
            view.leading.equalToSuperview().offset(12)
            view.trailing.equalToSuperview().inset(12)
            view.height.equalTo(18)
        }

        intro.snp.makeConstraints { view in
            view.top.equalTo(followers.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(12)
            view.trailing.equalToSuperview().inset(12)
        }

        information.snp.makeConstraints { view in
            view.top.equalTo(intro.snp.bottom).offset(20)
            view.leading.equalToSuperview().offset(12)
            view.trailing.equalToSuperview().inset(12)
            view.height.equalTo(25)
        }

        info.snp.makeConstraints { view in
            view.top.equalTo(information.snp.bottom).offset(8)
            view.leading.equalToSuperview().offset(12)
            view.trailing.equalToSuperview().inset(12)
        }

        lastPublication.snp.makeConstraints { view in
            view.top.equalTo(info.snp.bottom).offset(20)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
        }
    }
}

//MARK: Make buttons actions
extension ProfileViewController {
    
    private func makeButtonsAction() {
        
    }

    private func setupNavigationBar() {
        let paymentButton = UIBarButtonItem(
            image: UIImage(named: "proIcon"),
            style: .plain,
            target: self,
            action: #selector(openPayment)
        )

        navigationItem.rightBarButtonItems = [paymentButton]
    }

    private func timeAgo(from timeStamp: String) -> String? {
        guard let timeInterval = TimeInterval(timeStamp) else {
            return nil // Некорректный формат
        }

        let postDate = Date(timeIntervalSince1970: timeInterval)
        let currentDate = Date()
        let elapsedTime = currentDate.timeIntervalSince(postDate)

        let hours = Int(elapsedTime / 3600)
        if hours == 0 {
            return "Less than an hour ago"
        } else if hours == 1 {
            return "1 hour ago"
        } else {
            return "\(hours) hours ago"
        }
    }

    @objc private func openPayment() {
        guard let navigationController = self.navigationController else { return }

        ProfileRouter.showPaymentViewController(in: navigationController)
    }

    private func fetchImageUsingSDWebImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        SDWebImageManager.shared.loadImage(
            with: url,
            options: .highPriority,
            progress: nil
        ) { image, data, error, cacheType, finished, imageURL in
            if let error = error {
                print("Failed to fetch image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            completion(image)
        }
    }
}

extension ProfileViewController: IViewModelableController {
    typealias ViewModel = IProfileViewModel
}

//MARK: Preview
import SwiftUI

struct ProfileViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let profileViewController = ProfileViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<ProfileViewControllerProvider.ContainerView>) -> ProfileViewController {
            return profileViewController
        }

        func updateUIViewController(_ uiViewController: ProfileViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ProfileViewControllerProvider.ContainerView>) {
        }
    }
}
