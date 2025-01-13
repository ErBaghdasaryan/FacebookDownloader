//
//  TabBarViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 11.12.24.
//

import UIKit
import AppViewModel
import SnapKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        lazy var homeViewController = self.createNavigation(title: "Home",
                                                            image: "home",
                                                            vc: ViewControllerFactory.makeHomeViewController())

        lazy var collectionViewController = self.createNavigation(title: "Collection",
                                                                  image: "collection",
                                                                  vc: ViewControllerFactory.makeCollectionViewController())

        lazy var historyViewController = self.createNavigation(title: "History",
                                                               image: "history",
                                                               vc: ViewControllerFactory.makeHistoryViewController())

        lazy var settingsPageViewController = self.createNavigation(title: "Settings",
                                                                    image: "settings",
                                                                    vc: ViewControllerFactory.makeSettingsViewController())

        self.setViewControllers([homeViewController, collectionViewController, historyViewController, settingsPageViewController], animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(setCurrentPageToTeam), name: Notification.Name("ResetCompleted"), object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setCurrentPageToTeam),
            name: NSNotification.Name("UpdateDataNotification"),
            object: nil
        )

        homeViewController.delegate = self
        collectionViewController.delegate = self
        historyViewController.delegate = self
        settingsPageViewController.delegate = self
    }

    @objc func setCurrentPageToTeam() {
        self.selectedIndex = 2
    }

    private func createNavigation(title: String, image: String, vc: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: vc)
        self.tabBar.backgroundColor = UIColor.white.withAlphaComponent(0.35)
        self.tabBar.barTintColor = UIColor.black
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor(hex: "#1877F2")!.cgColor

        let unselectedImage = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: image)?.withTintColor(UIColor(hex: "#1877F2")!, renderingMode: .alwaysTemplate)

        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage

        navigation.tabBarItem.title = title

        let nonselectedTitleColor: UIColor = UIColor.gray
        let selectedTitleColor: UIColor = UIColor(hex: "#1877F2")!

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: nonselectedTitleColor
        ]
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: selectedTitleColor
        ]

        navigation.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        navigation.tabBarItem.setTitleTextAttributes(normalAttributes, for: .normal)

        return navigation
    }

    // MARK: - Deinit
    deinit {
        #if DEBUG
        print("deinit \(String(describing: self))")
        #endif
    }
}

//MARK: Navigation & TabBar Hidden
extension TabBarViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
            self.tabBar.isHidden = true
        } else {
            self.tabBar.isHidden = false
        }
    }
}

//MARK: Preview
import SwiftUI

struct TabBarViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let tabBarViewController = TabBarViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) -> TabBarViewController {
            return tabBarViewController
        }

        func updateUIViewController(_ uiViewController: TabBarViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TabBarViewControllerProvider.ContainerView>) {
        }
    }
}
