//
//  AppFlowCoordinator.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import UIKit

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinatorable)
}

protocol Coordinatorable: AnyObject {
    #warning("child를 들고 있는 이유는???")
    var childCoordinators: [Coordinatorable] { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get }
    func start()
    func finish()
}

extension Coordinatorable {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

final class AppFlowCoordinator: Coordinatorable {
    
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    var childCoordinators: [Coordinatorable] = []
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        switch UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.key) {
        case true:      showTabBar()
        case false:     showLoginView()
        }
    }
}

#warning("navigation 관련해서 순환 참조 발생할 위험 있는지???")
#warning("chilCoordinators 수정하는 부분 리팩토링 필요")
extension AppFlowCoordinator: AuthCoordinatorDelegate {
    func showTabBar() {
        let tabBarSceneDIContainer = appDIContainer.makeTabBarSceneDIContainer()
        let flow = tabBarSceneDIContainer.makeTabBarFlowCoordinator()
        flow.delegate = self
        childCoordinators = [flow]
        navigationController.viewControllers.removeAll()
        flow.start()
    }
}

extension AppFlowCoordinator: TabBarCoordinatorDelegate {
    func showLoginView() {
        let AuthSceneDIContainer = appDIContainer.makeAuthSceneDIContainer()
        let flow = AuthSceneDIContainer.makeAuthCoordinator(navigationController: navigationController)
        flow.delegate = self
        childCoordinators = [flow]
        navigationController.viewControllers.removeAll()
        flow.start()
    }
}

#warning("coordinator 종료되는 시점 확인하는 부분 꼭 필요한가??")
//extension AppFlowCoordinator: CoordinatorFinishDelegate {
//    func coordinatorDidFinish(childCoordinator: Coordinatorable) {
//
//    }
//}
