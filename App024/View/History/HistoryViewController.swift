//
//  HistoryViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppViewModel
import SnapKit
import SDWebImage
import AppModel

final class HistoryViewController: BaseViewController {

    var viewModel: ViewModel?

    private let header = UILabel(text: "History",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Black", size: 28))
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.viewModel?.loadData()
        self.collectionView.reloadData()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white

        self.header.textAlignment = .left

        let numberOfColumns: CGFloat = 2
        let spacing: CGFloat = 12
        let totalSpacing = ((numberOfColumns - 1) * spacing)
        let availableWidth = self.view.frame.width - totalSpacing
        let itemWidth = availableWidth / numberOfColumns

        let myLayout = UICollectionViewFlowLayout()
        myLayout.itemSize = CGSize(width: itemWidth, height: 272)
        myLayout.scrollDirection = .vertical
        myLayout.minimumLineSpacing = spacing
        myLayout.minimumInteritemSpacing = spacing

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: myLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(RecentlyCollectionViewCell.self)
        collectionView.register(EmptyCollectionViewCell.self)

        collectionView.delegate = self
        collectionView.dataSource = self

        self.view.addSubview(header)
        self.view.addSubview(collectionView)
        setupConstraints()
        setupNavigationBar()
    }

    override func setupViewModel() {
        super.setupViewModel()
        self.viewModel?.loadData()
        self.collectionView.reloadData()
    }

    func setupConstraints() {

        header.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(60)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(32)
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(50)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.bottom.equalToSuperview()
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
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
        let alert = UIAlertController(title: "Delete All history?",
                                      message: "If you delete the history, all history folder will be lost",
                                      preferredStyle: .alert)

        let clearAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.viewModel?.deleteAllHistory()
            self.viewModel?.loadData()
            self.collectionView.reloadData()
        }
        alert.addAction(clearAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func fetchImageUsingSDWebImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        SDWebImageManager.shared.loadImage(
            with: url,
            options: .highPriority,
            progress: nil
        ) { image, data, error, cacheType, finished, imageURL in
            if let error = error {
                print("Failed to fetch image: \(error.localizedDescription)")
                completion(nil)
                return
            }

            completion(image)
        }
    }

    private func deleteFile(by index: Int) {
        guard let deletedFileId = self.viewModel?.recentlies[index].id else { return }

        let alert = UIAlertController(title: "Delete File?",
                                      message: "Do you really want to delete this file from your history?",
                                      preferredStyle: .alert)

        let clearAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.viewModel?.deleteFile(for: deletedFileId)
            self.viewModel?.loadData()
            self.collectionView.reloadData()
        }
        alert.addAction(clearAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }

    private func showPostViewController(model: Download) {
        guard let navigationController = self.navigationController else { return }
        guard let subject = self.viewModel?.activateSuccessSubject else { return }

        let navModel = PostNavigationModel(activateSuccessSubject: subject,
                                           model: model)

        HistoryRouter.showPostViewController(in: navigationController,
                                             navigationModel: navModel)
    }
}

extension HistoryViewController: IViewModelableController {
    typealias ViewModel = IHistoryViewModel
}

extension HistoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel?.recentlies.count ?? 0
        return count == 0 ? 1 : count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.viewModel?.recentlies.isEmpty ?? true {
            let cell: EmptyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupUI()
            return cell
        } else {
            let cell: RecentlyCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            if let model = self.viewModel?.recentlies[indexPath.row] {
                self.fetchImageUsingSDWebImage(from: model.thumbnail!) { image in
                    let isVideo = model.video == nil ? false : true
                    if let image = image {
                        cell.setup(image: image, isVideo: isVideo)
                    } else {
                        print("Failed to fetch image")
                    }
                }
            }

            cell.deleteSubject.sink { [weak self] _ in
                self?.deleteFile(by: indexPath.row)
            }.store(in: &cell.cancellables)

            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.viewModel?.recentlies.isEmpty == true {
            return CGSize(width: 294, height: 349)
        } else {
            let numberOfColumns: CGFloat = 2
            let spacing: CGFloat = 12
            let totalSpacing = ((numberOfColumns - 1) * spacing)
            let availableWidth = (self.view.frame.width - 32) - totalSpacing
            let itemWidth = availableWidth / numberOfColumns

            return CGSize(width: itemWidth, height: 272)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = self.viewModel?.recentlies[indexPath.row] else { return }

        self.showPostViewController(model: .init(title: model.title,
                                                 thumbnail: model.thumbnail,
                                                 audio: model.audio,
                                                 video: model.video,
                                                 duration: model.duration))
    }
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
