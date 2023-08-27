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
    
}

protocol LoginViewModelOutput {
    
}

protocol LoginViewModel: LoginViewModelInput, LoginViewModelOutput {}

final class DefaultLoginViewModel: LoginViewModel {
    
    private let actions: LoginViewModelActions
    
    init(actions: LoginViewModelActions) {
        self.actions = actions
    }
}
