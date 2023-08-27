//
//  LoginViewModel.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/27.
//

import Foundation

struct LoginViewModelActions {
    let showTabBar: () -> Void
}

protocol LoginViewModelInput {
    func loginButtonTapped()
}

protocol LoginViewModelOutput {
    
}

protocol LoginViewModel: LoginViewModelInput, LoginViewModelOutput {}

final class DefaultLoginViewModel: LoginViewModel {
    
    private let actions: LoginViewModelActions
    
    init(actions: LoginViewModelActions) {
        self.actions = actions
    }
    
    // MARK: - Input
    func loginButtonTapped() {
        UserDefaults.standard.set(true, forKey: UserDefaultsKeys.isLoggedIn.key)
        actions.showTabBar()
    }
}
