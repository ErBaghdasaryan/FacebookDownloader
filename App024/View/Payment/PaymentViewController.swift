//
//  PaymentViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import UIKit
import AppViewModel
import SnapKit

final class PaymentViewController: BaseViewController {

    var viewModel: ViewModel?

    private let topImage = UIImageView(image: .init(named: "paymentImage"))
    private let header = UILabel(text: "Save unlimeted Stories",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Bold", size: 28))
    private let forFreeButton = UIButton(type: .system)
    private let continueButton = UIButton(type: .system)
    private var currentIndex: Int = 0

    private let firstUnlimeted = IconLabelView(image: UIImage(named: "checkmarkBlue")!,
                                               text: "Unlimited saving profiles",
                                               textHeight: 15,
                                               imageSize: CGSize(width: 24,
                                                                 height: 24))
    private let secondUnlimeted = IconLabelView(image: UIImage(named: "checkmarkBlue")!,
                                               text: "Unlimited folders",
                                               textHeight: 15,
                                               imageSize: CGSize(width: 24,
                                                                 height: 24))
    private let thirdUnlimeted = IconLabelView(image: UIImage(named: "checkmarkBlue")!,
                                               text: "Unlimited download",
                                               textHeight: 15,
                                               imageSize: CGSize(width: 24,
                                                                 height: 24))
    private var unlimitedStack: UIStackView!

    private let cancelAnytime = IconLabelView(image: UIImage(named: "cancelAnytime")!,
                                              text: "Cancel Anytime",
                                              textHeight: 12,
                                              imageSize: CGSize(width: 17,
                                                                height: 17),
                                              spacing: 5)

    private let annualButton = PaymentButton(isAnnual: .annual)
    private let weeklyButton = PaymentButton(isAnnual: .weekly)
    private var plansStack: UIStackView!

    private let privacyButton = UIButton(type: .system)
    private let restoreButton = UIButton(type: .system)
    private let termsButton = UIButton(type: .system)
    private var bottomStack: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.forFreeButton.isHidden = false
        }
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white
        header.textAlignment = .center
        header.numberOfLines = 1

        self.forFreeButton.setImage(.init(named: "paymentClose"), for: .normal)

        self.continueButton.setImage(UIImage(named: "continueButton"), for: .normal)

        self.plansStack = UIStackView(arrangedSubviews: [annualButton,
                                                         weeklyButton],
                                      axis: .vertical,
                                      spacing: 8)

        self.privacyButton.setTitle("Privacy Policy", for: .normal)
        self.privacyButton.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
        self.privacyButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
        self.restoreButton.setTitle("Restore Purchases", for: .normal)
        self.restoreButton.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
        self.restoreButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
        self.termsButton.setTitle("Terms of Use", for: .normal)
        self.termsButton.setTitleColor(.black.withAlphaComponent(0.6), for: .normal)
        self.termsButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 12)
        self.bottomStack = UIStackView(arrangedSubviews: [privacyButton, restoreButton, termsButton],
                                       axis: .horizontal,
                                       spacing: 12)

        self.unlimitedStack = UIStackView(arrangedSubviews: [firstUnlimeted,
                                                             secondUnlimeted,
                                                             thirdUnlimeted],
                                          axis: .vertical,
                                          spacing: 2)

        self.forFreeButton.isHidden = true

        self.view.addSubview(topImage)
        self.view.addSubview(header)
        self.view.addSubview(continueButton)
        self.view.addSubview(forFreeButton)
        self.view.addSubview(unlimitedStack)
        self.view.addSubview(plansStack)
        self.view.addSubview(cancelAnytime)
        self.view.addSubview(bottomStack)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {
        topImage.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(487)
        }

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(361)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(41)
        }

        continueButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(88)
            view.leading.equalToSuperview().offset(64)
            view.trailing.equalToSuperview().inset(64)
            view.height.equalTo(54)
        }

        forFreeButton.snp.makeConstraints { view in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(11)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
            view.width.equalTo(23)
        }

        unlimitedStack.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(10)
            view.leading.equalToSuperview().offset(93.5)
            view.trailing.equalToSuperview().inset(93.5)
            view.height.equalTo(100)
        }

        plansStack.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(138)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(118)
        }

        cancelAnytime.snp.makeConstraints { view in
            view.top.equalTo(plansStack.snp.bottom).offset(16)
            view.centerX.equalToSuperview()
            view.width.equalTo(115)
            view.height.equalTo(24)
        }

        bottomStack.snp.makeConstraints { view in
            view.top.equalTo(continueButton.snp.bottom).offset(26)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(13)
        }
    }

}

//MARK: Make buttons actions
extension PaymentViewController {
    
    private func makeButtonsAction() {
        continueButton.addTarget(self, action: #selector(continueButtonTaped), for: .touchUpInside)
        forFreeButton.addTarget(self, action: #selector(forFreeButtonTapped), for: .touchUpInside)
        annualButton.addTarget(self, action: #selector(planAction(_:)), for: .touchUpInside)
        weeklyButton.addTarget(self, action: #selector(planAction(_:)), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(privacyTapped), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(termsTapped), for: .touchUpInside)
//        restoreButt/*on.addTarget(self, action: #selector(restore), for: .touchUpInside)*/
    }

    @objc func privacyTapped() {
        guard let navigationController = self.navigationController else { return }
        PaymentRouter.showUsageViewController(in: navigationController)
    }

    @objc func termsTapped() {
        guard let navigationController = self.navigationController else { return }
        PaymentRouter.showTermsViewController(in: navigationController)
    }

    
    @objc func planAction(_ sender: UIButton) {
        switch sender {
        case annualButton:
            self.annualButton.isSelectedState = true
            self.weeklyButton.isSelectedState = false
//            self.currentProduct = self.productsAppHud.first
        case weeklyButton:
            self.annualButton.isSelectedState = false
            self.weeklyButton.isSelectedState = true
//            self.currentProduct = self.productsAppHud[1]
        default:
            break
        }
    }

    @objc func forFreeButtonTapped() {
        if let navigationController = self.navigationController {
            let viewControllers = navigationController.viewControllers

            if let currentIndex = viewControllers.firstIndex(of: self), currentIndex > 0 {
                let previousViewController = viewControllers[currentIndex - 1]

                if previousViewController is OnboardingViewController {
                    UntilOnboardingRouter.showTabBarViewController(in: navigationController)
                } else {
                    UntilOnboardingRouter.popViewController(in: navigationController)
                }
            }
        }
    }

    @objc func continueButtonTaped() {
//        if let navigationController = self.navigationController {
////            guard let currentProduct = self.currentProduct else { return }
//
//            startPurchase(product: currentProduct) { result in
//                let viewControllers = navigationController.viewControllers
//
//                if let currentIndex = viewControllers.firstIndex(of: self), currentIndex > 0 {
//                    let previousViewController = viewControllers[currentIndex - 1]
//
//                    if previousViewController is OnboardingViewController {
//                        UntilOnboardingRouter.showTabBarViewController(in: navigationController)
//                    } else {
//                        UntilOnboardingRouter.popViewController(in: navigationController)
//                    }
//                }
//            }
//        }

    }
}

extension PaymentViewController: IViewModelableController {
    typealias ViewModel = IPaymentViewModel
}

//MARK: Preview
import SwiftUI

struct PaymentViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let paymentViewController = PaymentViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PaymentViewControllerProvider.ContainerView>) -> PaymentViewController {
            return paymentViewController
        }

        func updateUIViewController(_ uiViewController: PaymentViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<PaymentViewControllerProvider.ContainerView>) {
        }
    }
}
