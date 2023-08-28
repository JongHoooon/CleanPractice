//
//  TVSeriesCoordinator.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

protocol TVSeriesCoordinatorDependencies {
    func makeTVSeriesViewController(actions: TVSeriesListViewModelActions) -> TVSeriesListViewController
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController
}

protocol TVSeriesCoordinatorDelegate: AnyObject {
    func showLoginView()
}

final class TVSeriesCoordinator: Coordinatorable {
    
    private let navigationController: UINavigationController
    private let dependencies: TVSeriesCoordinatorDependencies
    var childCoordinators: [Coordinatorable] = []
    var finishDelegate: CoordinatorFinishDelegate?
    weak var delegate: TVSeriesCoordinatorDelegate?
    
    init(
        navigationController: UINavigationController,
        dependencies: TVSeriesCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = TVSeriesListViewModelActions(showLogin: showLogin)
        let vc = dependencies.makeTVSeriesViewController(actions: actions)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showLogin() {
        delegate?.showLoginView()
    }
}
