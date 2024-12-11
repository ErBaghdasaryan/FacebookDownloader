//
//  UntilOnboardingViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import UIKit
import AppViewModel
import SnapKit

class UntilOnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    private let backgroundImage = UIImageView(image: .init(named: "untilOnboardingBG"))
    private let logoImage = UIImageView(image: .init(named: "Image"))
    private var activityIndicator = UIActivityIndicatorView(style: .large)

    private var timer: Timer?
    private var activityCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
    }

    override func setupUI() {
        super.setupUI()

        self.logoImage.layer.masksToBounds = true
        self.logoImage.layer.cornerRadius = 40

        self.activityIndicator.color = .black
        self.activityIndicator.startAnimating()

        self.view.addSubview(backgroundImage)
        self.view.addSubview(logoImage)
        self.view.addSubview(activityIndicator)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()

    }

    func setupConstraints() {

        backgroundImage.snp.makeConstraints { view in
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.top.equalToSuperview()
        }

        logoImage.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(304)
            view.centerX.equalToSuperview()
            view.height.equalTo(160)
            view.width.equalTo(160)
        }

        activityIndicator.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(74)
            view.centerX.equalToSuperview()
            view.height.equalTo(32)
            view.width.equalTo(32)
        }
    }
}


extension UntilOnboardingViewController: IViewModelableController {
    typealias ViewModel = IUntilOnboardingViewModel
}

//MARK: Progress View
extension UntilOnboardingViewController {
    private func startLoading() {
        activityCount = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateActivityIndicator), userInfo: nil, repeats: true)
    }

    @objc private func updateActivityIndicator() {
        activityCount += 1
        if activityCount >= 2 {
            timer?.invalidate()
            activityIndicator.stopAnimating()
            goToNextPage()
        }
    }

    private func goToNextPage() {
        guard let navigationController = self.navigationController else { return }
        guard var viewModel = self.viewModel else { return }
        if viewModel.appStorageService.hasData(for: .skipOnboarding) {
            UntilOnboardingRouter.showTabBarViewController(in: navigationController)
        } else {
            viewModel.skipOnboarding = true
            UntilOnboardingRouter.showOnboardingViewController(in: navigationController)
        }
    }
}

//MARK: Preview
import SwiftUI

struct UntilOnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let untilOnboardingViewController = UntilOnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<UntilOnboardingViewControllerProvider.ContainerView>) -> UntilOnboardingViewController {
            return untilOnboardingViewController
        }

        func updateUIViewController(_ uiViewController: UntilOnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<UntilOnboardingViewControllerProvider.ContainerView>) {
        }
    }
}
