//
//  ContuctUsViewController.swift
//  App024
//
//  Created by Er Baghdasaryan on 18.12.24.
//

import UIKit
import WebKit
import SnapKit

final class ContuctUsViewController: BaseViewController {

    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setupUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.webView.backgroundColor = .clear
        if let url = URL(string: "https://docs.google.com/forms/d/1OhWb0gqK_a3mKcw5AsS20pfJrS8zL9697i3eU-Gbs7c/edit") {
            webView.load(URLRequest(url: url))
        }

        setupConstraints()
    }

    private func setupConstraints() {
        self.view.addSubview(webView)

        webView.snp.makeConstraints { view in
            view.top.equalToSuperview()
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
        }
    }

    override func setupViewModel() {

    }

}

import SwiftUI

struct ContuctUsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let contuctUsViewController = ContuctUsViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ContuctUsViewControllerProvider.ContainerView>) -> ContuctUsViewController {
            return contuctUsViewController
        }

        func updateUIViewController(_ uiViewController: ContuctUsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<ContuctUsViewControllerProvider.ContainerView>) {
        }
    }
}
