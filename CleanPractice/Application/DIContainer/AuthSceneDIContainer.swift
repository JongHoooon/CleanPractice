//
//  AuthSceneDIContainer.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/27.
//

import UIKit

struct AuthSceneDIContainer {
    func makeAuthCoordinator(
        navigationController: UINavigationController
    ) -> AuthCoordinator {
        
        return AuthCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}

extension AuthSceneDIContainer: AuthCoordinatorDependencies {
    
    // MARK: - Login View
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel(actions: actions))
    }
    
    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        return DefaultLoginViewModel (actions: actions)
    }
}
