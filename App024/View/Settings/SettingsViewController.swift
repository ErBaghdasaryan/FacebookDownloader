//
//  SettingsViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppViewModel
import SnapKit
import StoreKit
import Toast
import ApphudSDK

final class SettingsViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "Settings",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var style = ToastStyle()

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

        self.style.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.style.messageColor = UIColor.white

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

    private func tappedCell(from index: Int) {
        guard let navigationController = self.navigationController else { return }
        switch index {
        case 0:
            SettingsRouter.showPaymentViewController(in: navigationController)
        case 1:
            self.restorePurchase { result in
                self.view.makeToast("Restore completed", duration: 2.0, position: .bottom, style: self.style)
            }
        case 2:
            showClearCacheAlert()
        case 3:
            self.rateTapped()
        case 4:
            self.shareTapped()
        case 5:
            SettingsRouter.showContuctUsViewController(in: navigationController)
        case 6:
            SettingsRouter.showPrivacyViewController(in: navigationController)
        case 7:
            SettingsRouter.showTermsViewController(in: navigationController)
        default:
            break
        }

    }

    @MainActor
    func restorePurchase(escaping: @escaping(Bool) -> Void) {
        Apphud.restorePurchases { subscriptions, _, error in
            if let error = error {
                print(error.localizedDescription)
                escaping(false)
            }
            if subscriptions?.first?.isActive() ?? false {
                escaping(true)
            }
            if Apphud.hasActiveSubscription() {
                escaping(true)
            }
        }
    }

    private func showClearCacheAlert() {
        let alertController = UIAlertController(
            title: "Clear cache?",
            message: "The cached files of your videos will be deleted from your phone's memory. But your download history will be retained.",
            preferredStyle: .alert
        )

        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { _ in
            self.clearAppCache()
            self.clearTemporaryFiles()
        }
        alertController.addAction(clearAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    private func clearAppCache() {
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        do {
            let cacheFiles = try FileManager.default.contentsOfDirectory(atPath: cacheURL?.path ?? "")
            for file in cacheFiles {
                let fileURL = cacheURL?.appendingPathComponent(file)
                try FileManager.default.removeItem(at: fileURL!)
            }
            self.view.makeToast("Cache cleared successfully", duration: 2.0, position: .bottom, style: style)
        } catch {
            self.view.makeToast("Failed to clear cache", duration: 2.0, position: .bottom, style: style)
        }
    }

    private func clearTemporaryFiles() {
        let tempDir = NSTemporaryDirectory()

        do {
            let tempFiles = try FileManager.default.contentsOfDirectory(atPath: tempDir)
            for file in tempFiles {
                let filePath = tempDir + file
                try FileManager.default.removeItem(atPath: filePath)
            }
            self.view.makeToast("Cache cleared successfully", duration: 2.0, position: .bottom, style: style)
        } catch {
            self.view.makeToast("Failed to clear temporary files", duration: 2.0, position: .bottom, style: style)
        }
    }

    @objc func shareTapped() {
        let appStoreURL = URL(string: "https://apps.apple.com/us/app/id6739563851")!

        let activityViewController = UIActivityViewController(activityItems: [appStoreURL], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view

        activityViewController.excludedActivityTypes = [
            .postToWeibo,
            .print,
            .assignToContact,
            .saveToCameraRoll,
            .addToReadingList,
            .postToFlickr,
            .postToVimeo,
            .postToTencentWeibo,
            .openInIBooks,
            .markupAsPDF,
            .mail,
            .airDrop,
            .postToFacebook,
            .postToTwitter,
            .copyToPasteboard
        ]

        present(activityViewController, animated: true, completion: nil)
    }

    @objc func rateTapped() {
        guard let scene = view.window?.windowScene else { return }
        if #available(iOS 14.0, *) {
            SKStoreReviewController.requestReview()
        } else {
            let alertController = UIAlertController(
                title: "Enjoying the app?",
                message: "Please consider leaving us a review in the App Store!",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Go to App Store", style: .default) { _ in
                if let appStoreURL = URL(string: "https://apps.apple.com/us/app/id6739563851") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            })
            present(alertController, animated: true, completion: nil)
        }
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

    private func calculateOverallIndex(for indexPath: IndexPath) -> Int {
        var overallIndex = 0

        for section in 0..<indexPath.section {
            overallIndex += viewModel?.settingsItems[section].items.count ?? 0
        }

        overallIndex += indexPath.row

        return overallIndex
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
        let rows = viewModel?.settingsItems[section].items.count ?? 0
        let isLastSection = section == (viewModel?.settingsItems.count ?? 1) - 1
        return isLastSection ? rows + 1 : rows
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
        let isLastSection = indexPath.section == (viewModel?.settingsItems.count ?? 1) - 1
            let lastRowIndex = (viewModel?.settingsItems[indexPath.section].items.count ?? 0)
        if isLastSection && indexPath.row == lastRowIndex {
            let cell = UITableViewCell()
            cell.selectionStyle = .none
            cell.textLabel?.text = "App version: 1.0.0"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .darkGray
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            if let item = self.viewModel?.settingsItems[indexPath.section].items[indexPath.row] {
                cell.textLabel?.text = item.title
                cell.imageView?.image = item.icon
                cell.accessoryType = item.accessoryType
                cell.selectionStyle = .none
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isLastSection = indexPath.section == (viewModel?.settingsItems.count ?? 1) - 1
        let lastRowIndex = (viewModel?.settingsItems[indexPath.section].items.count ?? 0)

        if isLastSection && indexPath.row == lastRowIndex {
            return
        } else {
            let overallIndex = calculateOverallIndex(for: indexPath)
            self.tappedCell(from: overallIndex)
        }
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
