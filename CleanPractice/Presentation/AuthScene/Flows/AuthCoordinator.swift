//
//  AuthCoordinator.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/27.
//

import UIKit

protocol AuthCoordinatorDependencies {
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
}

protocol AuthCoordinatorDelegate: AnyObject {
    func showTabBar()
}

#warning("login vc를 들고 있는게 맞는지??")
final class AuthCoordinator: Coordinatorable {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    private let dependencies: AuthCoordinatorDependencies
    weak var delegate: AuthCoordinatorDelegate?
    var childCoordinators: [Coordinatorable] = []
    
    init(
        navigationController: UINavigationController,
        dependencies: AuthCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        guard let showTabBar = delegate?.showTabBar else {
            fatalError("Auth Delegate is not linked")
        }
        
        let actions = LoginViewModelActions(showTabBar: showTabBar)
        let vc = dependencies.makeLoginViewController(actions: actions)
        navigationController.pushViewController(vc, animated: true)
    }
}
