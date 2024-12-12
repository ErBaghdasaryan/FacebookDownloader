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

    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        setupTableView()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white

        self.header.textAlignment = .left

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.view.addSubview(header)
        self.view.addSubview(tableView)
        setupConstraints()
        setupNavigationBar()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.tableView.reloadData()
    }

    func setupConstraints() {

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(60)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
        }

        tableView.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(24)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }

//        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.registerHeaderFooterView(SectionHeaderView.self)
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
        guard let navigationController = self.navigationController else { return }

        SettingsRouter.showPaymentViewController(in: navigationController)
    }
}

extension SettingsViewController: IViewModelableController {
    typealias ViewModel = ISettingsViewModel
}

//MARK: TableView Delegate & Data source
extension SettingsViewController:  UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.settingsItems.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.settingsItems[section].items.count ?? 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: SectionHeaderView = tableView.dequeueReusableHeaderFooterView()
        header.setup(with: self.viewModel?.settingsItems[section].title ?? "")
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let item = self.viewModel?.settingsItems[indexPath.section].items[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.imageView?.image = item.icon
            cell.accessoryType = item.accessoryType
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
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
