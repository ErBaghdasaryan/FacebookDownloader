//
//  ViewControllerFactory.swift
//  App024
//
//  Created by Er Baghdasaryan on 10.12.24.
//

import Foundation
import Swinject
import AppModel
import AppViewModel

final class ViewControllerFactory {
    private static let commonAssemblies: [Assembly] = [ServiceAssembly()]

    //MARK: - UntilOnboarding
    static func makeUntilOnboardingViewController() -> UntilOnboardingViewController {
        let assembler = Assembler(commonAssemblies + [UntilOnboardingAssembly()])
        let viewController = UntilOnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IUntilOnboardingViewModel.self)
        return viewController
    }

    //MARK: Onboarding
    static func makeOnboardingViewController() -> OnboardingViewController {
        let assembler = Assembler(commonAssemblies + [OnboardingAssembly()])
        let viewController = OnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IOnboardingViewModel.self)
        return viewController
    }

    //MARK: Payment
    static func makePaymentViewController() -> PaymentViewController {
        let assembler = Assembler(commonAssemblies + [PaymentAssembly()])
        let viewController = PaymentViewController()
        viewController.viewModel = assembler.resolver.resolve(IPaymentViewModel.self)
        return viewController
    }

    //MARK: - TabBar
    static func makeTabBarViewController() -> TabBarViewController {
        let viewController = TabBarViewController()
        return viewController
    }

    //MARK: Home
    static func makeHomeViewController() -> HomeViewController {
        let assembler = Assembler(commonAssemblies + [HomeAssembly()])
        let viewController = HomeViewController()
        viewController.viewModel = assembler.resolver.resolve(IHomeViewModel.self)
        return viewController
    }

    //MARK: Instruction
    static func makeInstructionViewController() -> InstructionViewController {
        let assembler = Assembler(commonAssemblies + [InstructionAssembly()])
        let viewController = InstructionViewController()
        viewController.viewModel = assembler.resolver.resolve(IInstructionViewModel.self)
        return viewController
    }

    //MARK: Collection
    static func makeCollectionViewController() -> CollectionViewController {
        let assembler = Assembler(commonAssemblies + [CollectionAssembly()])
        let viewController = CollectionViewController()
        viewController.viewModel = assembler.resolver.resolve(ICollectionViewModel.self)
        return viewController
    }

    //MARK: History
    static func makeHistoryViewController() -> HistoryViewController {
        let assembler = Assembler(commonAssemblies + [HistoryAssembly()])
        let viewController = HistoryViewController()
        viewController.viewModel = assembler.resolver.resolve(IHistoryViewModel.self)
        return viewController
    }

    //MARK: Settings
    static func makeSettingsViewController() -> SettingsViewController {
        let assembler = Assembler(commonAssemblies + [SettingsAssembly()])
        let viewController = SettingsViewController()
        viewController.viewModel = assembler.resolver.resolve(ISettingsViewModel.self)
        return viewController
    }

    //MARK: PrivacyPolicy
    static func makePrivacyViewController() -> PrivacyViewController {
        let viewController = PrivacyViewController()
        return viewController
    }

    //MARK: Terms
    static func makeTermsViewController() -> TermsViewController {
        let viewController = TermsViewController()
        return viewController
    }

    //MARK: ContuctUs
    static func makeContuctUsViewController() -> ContuctUsViewController {
        let viewController = ContuctUsViewController()
        return viewController
    }

    //MARK: Profile
    static func makeProfileViewController(navigationModel: ProfileNavigationModel) -> ProfileViewController {
        let assembler = Assembler(commonAssemblies + [ProfileAssembly()])
        let viewController = ProfileViewController()
        viewController.viewModel = assembler.resolver.resolve(IProfileViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: Post
    static func makePostViewController(navigationModel: PostNavigationModel) -> PostViewController {
        let assembler = Assembler(commonAssemblies + [PostAssembly()])
        let viewController = PostViewController()
        viewController.viewModel = assembler.resolver.resolve(IPostViewModel.self, argument: navigationModel)
        return viewController
    }
}
