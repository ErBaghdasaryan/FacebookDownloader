//
//  SettingsViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppViewModel
import SnapKit

final class SettingsViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Settings",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white

        self.header.textAlignment = .left

        self.view.addSubview(header)
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
    }

}

//MARK: Make buttons actions
extension SettingsViewController {
    
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

    @objc private func openPayment() {
        print("First button tapped")
    }
}

extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: Preview
import SwiftUI

struct SettingsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let settingsViewController = SettingsViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) -> SettingsViewController {
            return settingsViewController
        }

        func updateUIViewController(_ uiViewController: SettingsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SettingsViewControllerProvider.ContainerView>) {
        }
    }
}
