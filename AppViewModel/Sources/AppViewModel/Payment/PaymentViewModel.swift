//
//  PaymentViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import Foundation
import AppModel

public protocol IPaymentViewModel {

}

public class PaymentViewModel: IPaymentViewModel {

    private let paymentService: IPaymentService

    public init(paymentService: IPaymentService) {
        self.paymentService = paymentService
    }
}
