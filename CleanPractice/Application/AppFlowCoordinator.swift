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
    var navigationController: UINavigationController { get set }
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
        #warning("로그인 여부 체크")
//        In App Flow we can check if user needs to login, if yes we would run login flow
//        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
//        let flow = moviesSceneDIContainer
//            .makeMoviesSceneCoordinator(navigationController: navigationController)
//
//        flow.start()
        
//        if
//        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
//            showTabBar()
//        } else
            
        switch UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.key) {
        case true:      showTabBar()
        case false:     showLoginView()
        }
    }
}

#warning("navigation 관련해서 순환 참조 발생할 위험 있는지???")
#warning("탭바 생성 후 탭바로 이동하게 수정해야함")
extension AppFlowCoordinator: AuthCoordinatorDelegate {
    func showTabBar() {
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer.makeMoviesSceneCoordinator(navigationController: navigationController)
        childCoordinators = [flow]
        navigationController.viewControllers.removeAll()
        flow.start()
    }
}

private extension AppFlowCoordinator {
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
