//
//  CollectionViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppViewModel
import SnapKit

final class CollectionViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Collection",
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
extension CollectionViewController {
    
    private func makeButtonsAction() {
        
    }

    private func setupNavigationBar() {
        let paymentButton = UIBarButtonItem(
            image: UIImage(named: "proIcon"),
            style: .plain,
            target: self,
            action: #selector(openPayment)
        )

        let addCollectionButton = UIBarButtonItem(
            image: UIImage(named: "addCollection"),
            style: .plain,
            target: self,
            action: #selector(addCollection)
        )

        navigationItem.rightBarButtonItems = [addCollectionButton, paymentButton]
    }

    @objc private func openPayment() {
        guard let navigationController = self.navigationController else { return }

        CollectionRouter.showPaymentViewController(in: navigationController)
    }

    @objc private func addCollection() {
        print("Second button tapped")
    }
}

extension CollectionViewController: IViewModelableController {
    typealias ViewModel = ICollectionViewModel
}

//MARK: Preview
import SwiftUI

struct CollectionViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let collectionViewController = CollectionViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<CollectionViewControllerProvider.ContainerView>) -> CollectionViewController {
            return collectionViewController
        }

        func updateUIViewController(_ uiViewController: CollectionViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<CollectionViewControllerProvider.ContainerView>) {
        }
    }
}
