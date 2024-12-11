//
//  OnboardingViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import UIKit
import AppViewModel
import SnapKit
import StoreKit

class OnboardingViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    var collectionView: UICollectionView!
    private let bottomView = UIView()
    private let shadow = UIImageView(image: .init(named: "backgroundShadow"))
    private let header = UILabel(text: "Header",
                                 textColor: .black,
                                 font: UIFont(name: "SFProText-Bold", size: 34))
    private let descriptionLabel = UILabel(text: "Description",
                                           textColor: .black.withAlphaComponent(0.6),
                                           font: UIFont(name: "SFProText-Semibold", size: 17))
    private let pageControl = AdvancedPageControlView()
    private let nextButton = UIButton(type: .system)
    private var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .white
        self.bottomView.backgroundColor = .white

        header.textAlignment = .center
        header.numberOfLines = 2

        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 1

        self.nextButton.setImage(UIImage(named: "continueButton"), for: .normal)

        let mylayout = UICollectionViewFlowLayout()
        mylayout.itemSize = sizeForItem()
        mylayout.scrollDirection = .horizontal
        mylayout.minimumLineSpacing = 0
        mylayout.minimumInteritemSpacing = 0

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: mylayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear

        collectionView.register(OnboardingCell.self)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false

        pageControl.drawer = ExtendedDotDrawer(numberOfPages: 4,
                                               height: 8,
                                               width: 8,
                                               space: 8,
                                               indicatorColor: UIColor.black,
                                               dotsColor: UIColor.black.withAlphaComponent(0.4),
                                               isBordered: true,
                                               borderWidth: 0.0,
                                               indicatorBorderColor: .orange,
                                               indicatorBorderWidth: 0.0)
        pageControl.setPage(0)

        self.view.addSubview(collectionView)
        self.view.addSubview(shadow)
        self.view.addSubview(bottomView)
        self.view.addSubview(header)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(nextButton)
        self.view.addSubview(pageControl)
        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel?.loadData()
    }

    func sizeForItem() -> CGSize {
        let deviceType = UIDevice.currentDeviceType

        switch deviceType {
        case .iPhone:
            let width = self.view.frame.size.width
            let heightt = self.view.frame.size.height
            return CGSize(width: width, height: heightt)
        case .iPad:
            let scaleFactor: CGFloat = 1.5
            let width = 550 * scaleFactor
            let height = 1100 * scaleFactor
            return CGSize(width: width, height: height)
        }
    }

    func setupConstraints() {
        shadow.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(138)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalTo(166)
        }

        bottomView.snp.makeConstraints { view in
            view.top.equalTo(shadow.snp.bottom)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }

        collectionView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview()
        }

        header.snp.makeConstraints { view in
            view.top.equalTo(shadow.snp.top).offset(40)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(82)
        }

        descriptionLabel.snp.makeConstraints { view in
            view.top.equalTo(header.snp.bottom).offset(6)
            view.leading.equalToSuperview().offset(16)
            view.trailing.equalToSuperview().inset(16)
            view.height.equalTo(22)
        }

         nextButton.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(80)
            view.leading.equalToSuperview().offset(72)
            view.trailing.equalToSuperview().inset(72)
            view.height.equalTo(52)
        }

        pageControl.snp.makeConstraints { view in
            view.bottom.equalToSuperview().inset(44)
            view.leading.equalToSuperview().offset(147)
            view.trailing.equalToSuperview().inset(147)
            view.height.equalTo(24)
        }
    }

}

//MARK: Make buttons actions
extension OnboardingViewController {
    
    private func makeButtonsAction() {
        nextButton.addTarget(self, action: #selector(nextButtonTaped), for: .touchUpInside)
    }

    private func resetLabelSizes(to page: Int) {
        switch page {
        case 1:
            pageControl.setPage(1)
            break
        case 2:
            pageControl.setPage(2)
            break
        case 3:
            pageControl.setPage(3)
            header.snp.remakeConstraints { view in
                view.top.equalTo(shadow.snp.top).offset(40)
                view.leading.equalToSuperview().offset(16)
                view.trailing.equalToSuperview().inset(16)
                view.height.equalTo(41)
            }

            self.header.numberOfLines = 1
            self.rate()
        default:
            pageControl.setPage(0)
            header.snp.remakeConstraints { view in
                view.top.equalTo(shadow.snp.top).offset(40)
                view.leading.equalToSuperview().offset(16)
                view.trailing.equalToSuperview().inset(16)
                view.height.equalTo(82)
            }

            self.header.numberOfLines = 2
        }
    }

    @objc func nextButtonTaped() {
        guard let navigationController = self.navigationController else { return }

        let numberOfItems = self.collectionView.numberOfItems(inSection: 0)
        let nextRow = self.currentIndex + 1

        if nextRow < numberOfItems {
            let nextIndexPath = IndexPath(item: nextRow, section: 0)
            self.collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            self.currentIndex = nextRow
            self.resetLabelSizes(to: currentIndex)
        } else {
            OnboardingRouter.showPaymentViewController(in: navigationController)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleItems = collectionView.indexPathsForVisibleItems.sorted()
        if let visibleItem = visibleItems.first {
            currentIndex = visibleItem.item
        }
    }

    private func rate() {
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
                if let appStoreURL = URL(string: "https://apps.apple.com/us/app/id6738990497") {
                    UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
                }
            })
            present(alertController, animated: true, completion: nil)
        }
    }
}

extension OnboardingViewController: IViewModelableController {
    typealias ViewModel = IOnboardingViewModel
}

extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel?.onboardingItems.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OnboardingCell = collectionView.dequeueReusableCell(for: indexPath)
        descriptionLabel.text = viewModel?.onboardingItems[indexPath.row].description
        header.text = viewModel?.onboardingItems[indexPath.row].header
        cell.setup(image: viewModel?.onboardingItems[indexPath.row].image ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return sizeForItem()
    }
}

//MARK: Preview
import SwiftUI

struct OnboardingViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let onboardingViewController = OnboardingViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) -> OnboardingViewController {
            return onboardingViewController
        }

        func updateUIViewController(_ uiViewController: OnboardingViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<OnboardingViewControllerProvider.ContainerView>) {
        }
    }
}
