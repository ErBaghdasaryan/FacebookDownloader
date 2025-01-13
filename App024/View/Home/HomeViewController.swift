//
//  HomeViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppViewModel
import SnapKit
import AppModel
import ApphudSDK

final class HomeViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Home",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    private let blueView = UIView()
    private let searchBar = UISearchBar()

    private let findButton = UIButton(type: .system)
    private var isAvailable: Bool = false {
        willSet {
            if newValue {
                findButton.isUserInteractionEnabled = true
                findButton.setImage(UIImage(named: "activeToFind"), for: .normal)
            } else {
                findButton.isUserInteractionEnabled = false
                findButton.setImage(UIImage(named: "unActiveToFind"), for: .normal)
            }
        }
    }
    private let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white

        self.header.textAlignment = .left

        self.blueView.backgroundColor = UIColor(hex: "#1877F2")?.withAlphaComponent(0.2)

        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.attributedPlaceholder = NSAttributedString(string: "Enter or Paste URL",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }

        searchBar.isOpaque = false
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.textColor = .gray
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.barTintColor = .clear
        searchBar.layer.masksToBounds = true
        searchBar.isTranslucent = true
        searchBar.delegate = self
        self.searchBar.backgroundColor = .clear
        self.searchBar.searchTextField.backgroundColor = .clear
        if let textField = searchBar.value(forKey: "searchField") as? UITextField,
           let leftView = textField.leftView as? UIImageView {
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = UIColor.black
        }

        searchBar.autocapitalizationType = .none
        searchBar.layer.borderWidth = 0.5
        searchBar.layer.borderColor = UIColor.gray.cgColor
        searchBar.layer.cornerRadius = 10

        self.isAvailable = false

        activityIndicator.color = UIColor(hex: "#27A5FF")
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .white
        activityIndicator.layer.masksToBounds = true
        activityIndicator.layer.cornerRadius = 16


        self.view.addSubview(header)
        self.view.addSubview(blueView)
        self.view.addSubview(searchBar)
        self.view.addSubview(findButton)
        self.view.addSubview(activityIndicator)
        setupConstraints()
        setupNavigationBar()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(60)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
        }

        blueView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(110)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }

        searchBar.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(296)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(52)
        }

        findButton.snp.makeConstraints { view in
            view.top.equalTo(searchBar.snp.bottom).offset(12)
            view.leading.equalToSuperview().offset(30)
            view.trailing.equalToSuperview().inset(30)
            view.height.equalTo(52)
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
extension HomeViewController {
    
    private func makeButtonsAction() {
        self.findButton.addTarget(self, action: #selector(find), for: .touchUpInside)
    }

    private func setupNavigationBar() {
        let paymentButton = UIBarButtonItem(
            image: UIImage(named: "proIcon"),
            style: .plain,
            target: self,
            action: #selector(openPayment)
        )

        let instructionButton = UIBarButtonItem(
            image: UIImage(named: "instruction"),
            style: .plain,
            target: self,
            action: #selector(openInstruction)
        )

        navigationItem.rightBarButtonItems = [instructionButton, paymentButton]
    }

    @objc private func openPayment() {
        guard let navigationController = self.navigationController else { return }

        HomeRouter.showPaymentViewController(in: navigationController)
    }

    @objc private func openInstruction() {
        guard let navigationController = self.navigationController else { return }

        HomeRouter.showInstructionViewController(in: navigationController)
    }

    private func showAlert(with title: String, and message: String) {
        if message == "" {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            let functionalButton = UIAlertAction(title: "Read instructions", style: .default) { _ in
                self.openInstruction()
            }

            let cancelButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)

            alert.addAction(cancelButton)
            alert.addAction(functionalButton)

            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
            
            let functionalButton = UIAlertAction(title: "Read instructions", style: .default) { _ in
                self.openInstruction()
            }

            let cancelButton = UIAlertAction(title: "Close", style: .cancel, handler: nil)

            alert.addAction(cancelButton)
            alert.addAction(functionalButton)

            self.present(alert, animated: true, completion: nil)
        }
    }

    private func showProfileViewController(model: ProfileModel) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let navModel = ProfileNavigationModel(activateSuccessSubject: subject,
                                              model: model)

        HomeRouter.showProfileViewController(in: navigationController,
                                             navigationModel: navModel)
    }

    private func showPostViewController(model: Download) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let navModel = PostNavigationModel(activateSuccessSubject: subject,
                                           model: model)

        HomeRouter.showPostViewController(in: navigationController,
                                             navigationModel: navModel)
    }

    @objc func find() {
        let searchKey = "searchCount"
        let maxFreeSearches = 10
        let currentSearchCount = UserDefaults.standard.integer(forKey: searchKey)

        if currentSearchCount < maxFreeSearches || Apphud.hasActiveSubscription() {
            UserDefaults.standard.set(currentSearchCount + 1, forKey: searchKey)

            guard let input = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !input.isEmpty else {
                self.showAlert(with: "Please enter url here", and: "")
                return
            }
            let token = "0118a92e-50df-48k72-8442-63043f133a61"
            
            self.view.endEditing(true)
            
            activityIndicator.startAnimating()
            
            if input.contains("/share/") || input.contains("video") {
                print("This is a video/audio URL")
                
                let params: [String: String] = ["url": input,
                                                "token": token]
                
                self.viewModel?.doCall(from: "https://faceapptest.site/api/download",
                                       httpMethod: "GET",
                                       urlParam: params,
                                       responseModel: PostResponseModel.self,
                                       completion: { (result: Result<PostResponseModel, Error>) in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        switch result {
                        case .success(let result):
                            print(result.data.download)
                            self.showPostViewController(model: result.data.download)
                            let post = result.data.download
                            if post.video == nil {
                                guard let imageURL = post.thumbnail else {
                                    return
                                }
                                self.viewModel?.addRecently(model: .init(title: post.title,
                                                                         thumbnail: post.thumbnail,
                                                                         audio: post.audio,
                                                                         video: post.video,
                                                                         duration: post.duration))
                            } else if post.video != nil,
                                      let thumbnail = post.video,
                                      let videoURL = URL(string: thumbnail) {
                                guard let imageURL = post.thumbnail else {
                                    return
                                }
                                self.viewModel?.addRecently(model: .init(title: post.title,
                                                                         thumbnail: post.thumbnail,
                                                                         audio: post.audio,
                                                                         video: post.video,
                                                                         duration: post.duration))
                            }
                        case .failure:
                            self.showAlert(with: "Loading error",
                                           and: "Paste a different link or try again later")
                        }
                    }
                })
                
            } else if input.contains(".com/") && !input.contains("/share/") {
                print("This is a profile URL")
                
                let params: [String: String] = ["url": input,
                                                "token": token]
                
                self.viewModel?.doCall(from: "https://faceapptest.site/api/profile",
                                       httpMethod: "GET",
                                       urlParam: params,
                                       responseModel: ProfileResponseModel.self,
                                       completion: { (result: Result<ProfileResponseModel, Error>) in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        switch result {
                        case .success(let result):
                            print(result.data.profile)
                            self.showProfileViewController(model: result.data.profile)
                        case .failure:
                            self.showAlert(with: "Loading error",
                                           and: "Paste a different link or try again later")
                        }
                    }
                })
            } else {
                self.activityIndicator.stopAnimating()
                self.showAlert(with: "Wrong link pasted",
                               and: "This link does not fit, enter another one or read our instructions")
            }
        }
    }
}

extension HomeViewController: IViewModelableController {
    typealias ViewModel = IHomeViewModel
}

//MARK: UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.searchTextField.text?.isEmpty ?? true {
            self.isAvailable = false
        } else {
            self.isAvailable = true
        }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.searchTextField.text?.isEmpty ?? true {
            self.isAvailable = false
        } else {
            self.isAvailable = true
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

//MARK: Preview
import SwiftUI

struct HomeViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let homeViewController = HomeViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) -> HomeViewController {
            return homeViewController
        }

        func updateUIViewController(_ uiViewController: HomeViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<HomeViewControllerProvider.ContainerView>) {
        }
    }
}
