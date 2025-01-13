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
    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.loadData()
        self.tableView.reloadData()
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
            view.top.equalTo(header.snp.bottom).offset(50)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }

        tableView.contentInset = UIEdgeInsets(top: -25, left: 0, bottom: 0, right: 0)
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(CollectionTableViewCell.self)
        self.tableView.register(EmptyTableViewCell.self)
    }
}

//MARK: TableView Delegate & Data source
extension CollectionViewController:  UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel?.collections.count ?? 0
        return count == 0 ? 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.viewModel?.collections.isEmpty ?? true {
            let cell: EmptyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupUI()
            return cell
        } else {
            let cell: CollectionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            if let model = viewModel?.collections[indexPath.row] {
                cell.setup(name: model.title, mediaCount: model.mediaCount)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.viewModel?.collections.isEmpty ?? true {
           return 349
        }else {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(
            name: NSNotification.Name("UpdateDataNotification"),
            object: nil,
            userInfo: nil
        )
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard !(self.viewModel?.collections.isEmpty ?? true) else { return nil }
        var delete: UIContextualAction?
        if let model = self.viewModel?.collections[indexPath.row] {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
                guard let self = self else { return }
                self.viewModel?.deleteCollection(by: model.id!)
                self.viewModel?.loadData()
                self.tableView.reloadData()
                completionHandler(true)
            }
            deleteAction.backgroundColor = .red
            delete = deleteAction
        }

        return UISwipeActionsConfiguration(actions: [delete!])
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
        let alertController = UIAlertController(
            title: "Create new Collection",
            message: "Enter a name for the new collection",
            preferredStyle: .alert
        )

        alertController.addTextField { textField in
            textField.placeholder = "Collection Name"
        }

        let createAction = UIAlertAction(title: "Create", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let collectionName = alertController.textFields?.first?.text, !collectionName.isEmpty {
                self.viewModel?.addCollection(model: .init(title: collectionName, mediaCount: 0))
                self.viewModel?.loadData()
                self.tableView.reloadData()
            } else {
                let errorAlert = UIAlertController(
                    title: "Error",
                    message: "Collection name cannot be empty.",
                    preferredStyle: .alert
                )
                errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(errorAlert, animated: true, completion: nil)
            }
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(createAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
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
