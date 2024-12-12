//
//  InstructionViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 12.12.24.
//

import UIKit
import AppViewModel
import SnapKit

final class InstructionViewController: BaseViewController {

    var viewModel: ViewModel?

    private let tableView = UITableView(frame: .zero, style: .grouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
        setupTableView()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white

        self.title = "Instruction"

        self.tableView.backgroundColor = .clear
        self.tableView.separatorStyle = .none
        self.tableView.allowsSelection = true

        self.navigationController?.navigationBar.tintColor = .black

        self.view.addSubview(tableView)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.tableView.reloadData()
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(107)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }

        tableView.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.showsVerticalScrollIndicator = false

        self.tableView.register(InstructionCell.self)
    }

}

//MARK: Make buttons actions
extension InstructionViewController {
    
    private func makeButtonsAction() {
        
    }
}

extension InstructionViewController: IViewModelableController {
    typealias ViewModel = IInstructionViewModel
}

//MARK: TableView Delegate & Data source
extension InstructionViewController:  UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.instructionItems.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InstructionCell = tableView.dequeueReusableCell(for: indexPath)
        if let collection = viewModel?.instructionItems[indexPath.row] {
            cell.setup(with: collection)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 328
    }
}


//MARK: Preview
import SwiftUI

struct InstructionViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let instructionViewController = InstructionViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<InstructionViewControllerProvider.ContainerView>) -> InstructionViewController {
            return instructionViewController
        }

        func updateUIViewController(_ uiViewController: InstructionViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<InstructionViewControllerProvider.ContainerView>) {
        }
    }
}
