//
//  PaymentButton.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import UIKit
import AppModel

final class PaymentButton: UIButton {
    private let title = UILabel(text: "",
                                textColor: .black,
                                font: UIFont(name: "SFProText-Regular", size: 17))
    private var image = UIImageView(image: .init(named: "unselectedState"))
    private let saveLabel = UILabel(text: "SAVE 60%",
                                    textColor: .white,
                                    font: UIFont(name: "SFProText-Regular", size: 11))
    private let annual = UILabel(text: "$1.04 per week",
                                 textColor: .black.withAlphaComponent(0.6),
                                 font: UIFont(name: "SFProText-Regular", size: 12))
    private let moneyForPayment = UILabel(text: "",
                                          textColor: .black,
                                          font: UIFont(name: "SFProText-Semibold", size: 17))
    private let perWeek = UILabel(text: "per week",
                                  textColor: .black.withAlphaComponent(0.4),
                                  font: UIFont(name: "SFProText-Regular", size: 12))
    var isSelectedState: Bool {
        willSet {
            if newValue {
                self.layer.borderWidth = 1
                self.layer.borderColor = UIColor(hex: "#27A5FF")?.cgColor
                self.image.image = UIImage(named: "selectedState")?.withRenderingMode(.alwaysTemplate)
                self.image.tintColor = UIColor(hex: "#27A5FF")
            } else {
                self.layer.borderWidth = 0
                self.layer.borderColor = UIColor.clear.cgColor
                self.image.image = UIImage(named: "unselectedState")?.withRenderingMode(.alwaysTemplate)
                self.image.tintColor = UIColor(hex: "#27A5FF")
            }
        }
    }
    private var isAnnual: PlanPresentationModel

    public init(isAnnual: PlanPresentationModel, isSelectedState: Bool = false) {
        self.isAnnual = isAnnual
        self.isSelectedState = isSelectedState
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.backgroundColor = UIColor(hex: "#36546A0A")!.withAlphaComponent(0.04)

        self.layer.cornerRadius = 12

        self.title.textAlignment = .left
        self.annual.textAlignment = .left

        self.saveLabel.backgroundColor = UIColor(hex: "#27A5FF")
        self.saveLabel.layer.masksToBounds = true
        self.saveLabel.layer.cornerRadius = 4

        self.moneyForPayment.textAlignment = .right
        self.perWeek.textAlignment = .right

        switch self.isAnnual {
        case .annual:
            self.title.text = "Annual"
            self.moneyForPayment.text = "$19.99"
            self.addSubview(saveLabel)
            self.addSubview(annual)
        case .weekly:
            self.title.text = "Weekly"
            self.moneyForPayment.text = "$4.99"
            break
        }

        self.isSelectedState = false

        addSubview(image)
        addSubview(title)
        addSubview(moneyForPayment)
        addSubview(perWeek)
        setupConstraints()
    }

    private func setupConstraints() {

        image.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(12)
            view.leading.equalToSuperview().offset(10)
            view.width.equalTo(24)
            view.height.equalTo(24)
        }

        switch self.isAnnual {
        case .annual:
            title.snp.makeConstraints { view in
                view.top.equalToSuperview().offset(8)
                view.leading.equalTo(image.snp.trailing).offset(8)
                view.trailing.equalToSuperview().inset(166)
                view.height.equalTo(22)
            }

            annual.snp.makeConstraints { view in
                view.top.equalTo(title.snp.bottom).offset(2)
                view.leading.equalTo(image.snp.trailing).offset(8)
                view.trailing.equalToSuperview().inset(166)
                view.height.equalTo(16)
            }

            saveLabel.snp.makeConstraints { view in
                view.top.equalToSuperview().offset(8.5)
                view.trailing.equalToSuperview().inset(78)
                view.width.equalTo(66)
                view.height.equalTo(21)
            }
        case .weekly:
            title.snp.makeConstraints { view in
                view.top.equalToSuperview().offset(17)
                view.leading.equalTo(image.snp.trailing).offset(8)
                view.trailing.equalToSuperview().inset(166)
                view.height.equalTo(22)
            }
        }

        moneyForPayment.snp.makeConstraints { view in
            view.top.equalToSuperview().offset(8)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(60)
            view.height.equalTo(22)
        }

        perWeek.snp.makeConstraints { view in
            view.top.equalTo(moneyForPayment.snp.bottom).offset(2)
            view.trailing.equalToSuperview().inset(16)
            view.width.equalTo(60)
            view.height.equalTo(16)
        }
    }

    public func setup(with isYearly: String) {
        self.title.text = isYearly
    }
}

enum PlanPresentationModel {
    case annual
    case weekly
}
