//
//  PostViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 07.01.25.
//

import UIKit
import AppViewModel
import SnapKit
import SDWebImage
import AVFoundation

final class PostViewController: BaseViewController {

    var viewModel: ViewModel?

    private let post = PostView()
    private var currentPlayer: AVPlayer?
    public let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white

        self.navigationController?.navigationBar.tintColor = .black

        self.post.layer.masksToBounds = true
        self.post.layer.cornerRadius = 30

        activityIndicator.color = UIColor(hex: "#27A5FF")
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .white
        activityIndicator.layer.masksToBounds = true
        activityIndicator.layer.cornerRadius = 16

        self.view.addSubview(post)
        self.view.addSubview(activityIndicator)
        setupConstraints()
        setupNavigationBar()
    }

    override func setupViewModel() {
        super.setupViewModel()

        guard let post = self.viewModel?.post else  { return }

        self.activityIndicator.startAnimating()

        if post.video == nil {
            self.title = "Image"
            guard let imageURL = post.thumbnail else {
                return
            }

            self.fetchImageUsingSDWebImage(from: imageURL) { image in
                if let image = image {
                    self.post.setup(image: image)
                } else {
                    print("Failed to fetch image")
                }
                self.activityIndicator.stopAnimating()
            }
        } else if post.video != nil, 
                    let thumbnail = post.video,
                    let videoURL = URL(string: thumbnail) {
            self.title = "Video/Audio"

            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.post.setupVideo(url: videoURL)
                    self.currentPlayer = self.post.player
                    self.currentPlayer?.play()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

    func setupConstraints() {
        post.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(126)
            view.leading.equalToSuperview().offset(13)
            view.trailing.equalToSuperview().inset(13)
            view.bottom.equalToSuperview().inset(142)
        }

        activityIndicator.snp.makeConstraints { view in
            view.centerX.equalToSuperview()
            view.centerY.equalToSuperview()
            view.width.equalTo(64)
            view.height.equalTo(64)
        }
    }
}

//MARK: Make buttons actions
extension PostViewController {
    
    private func makeButtonsAction() {
        
    }

    private func fetchImageUsingSDWebImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        self.activityIndicator.startAnimating()
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
//            self.post.activityIndicator.stopAnimating()
        }
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

    @objc private func openPayment() {
        guard let navigationController = self.navigationController else { return }

        PostRouter.showPaymentViewController(in: navigationController)
    }
}

extension PostViewController: IViewModelableController {
    typealias ViewModel = IPostViewModel
}

//MARK: Preview
import SwiftUI

struct PostViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let postViewController = PostViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<PostViewControllerProvider.ContainerView>) -> PostViewController {
            return postViewController
        }

        func updateUIViewController(_ uiViewController: PostViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PostViewControllerProvider.ContainerView>) {
        }
    }
}
