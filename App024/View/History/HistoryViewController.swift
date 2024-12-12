//
//  HistoryViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppViewModel
import SnapKit

final class HistoryViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "History",
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
extension HistoryViewController {
    
    private func makeButtonsAction() {
        
    }

    private func setupNavigationBar() {
        let paymentButton = UIBarButtonItem(
            image: UIImage(named: "proIcon"),
            style: .plain,
            target: self,
            action: #selector(openPayment)
        )

        let deleteButton = UIBarButtonItem(
            image: UIImage(named: "deleteBlack"),
            style: .plain,
            target: self,
            action: #selector(deleteHistory)
        )

        navigationItem.rightBarButtonItems = [deleteButton, paymentButton]
    }

    @objc private func openPayment() {
        guard let navigationController = self.navigationController else { return }

        HistoryRouter.showPaymentViewController(in: navigationController)
    }

    @objc private func deleteHistory() {
        print("Second button tapped")
    }
}

extension HistoryViewController: IViewModelableController {
    typealias ViewModel = IHistoryViewModel
}

//MARK: Preview
import SwiftUI

struct HistoryViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let historyViewController = HistoryViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<HistoryViewControllerProvider.ContainerView>) -> HistoryViewController {
            return historyViewController
        }

        func updateUIViewController(_ uiViewController: HistoryViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<HistoryViewControllerProvider.ContainerView>) {
        }
    }
}
