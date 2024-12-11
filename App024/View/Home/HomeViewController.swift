//
//  HomeViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppViewModel
import SnapKit

final class HomeViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Home",
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
extension HomeViewController {
    
    private func makeButtonsAction() {
        
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
        print("First button tapped")
    }

    @objc private func openInstruction() {
        print("Second button tapped")
    }
}

extension HomeViewController: IViewModelableController {
    typealias ViewModel = IHomeViewModel
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
