//
//  TabBarCoordinator.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/27.
//

import UIKit

protocol TabBarCoordinatorDependencies {
    func makeTabBarController() -> UITabBarController
    func makeMoviesDIContainer() -> MoviesSceneDIContainer
}

protocol TabBarCoordinatorDelegate: AnyObject {
    func showLoginView()
}

final class TabBarCoordinator: Coordinatorable {
    
    private let dependencies: TabBarCoordinatorDependencies
    var navigationController: UINavigationController
    var childCoordinators: [Coordinatorable] = []
    var finishDelegate: CoordinatorFinishDelegate?
    
    init(
        dependencies: TabBarCoordinatorDependencies,
        navigationController: UINavigationController
    ) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = dependencies.makeTabBarController()
        tabBarController.tabBar.tintColor = .label
        navigationController.pushViewController(tabBarController, animated: true)
        
        let moviesSceneNavigationController = UINavigationController()
        
        tabBarController.viewControllers = [
            moviesSceneNavigationController
        ]
        
        startMoviesScene(
            type: .movies,
            moviesSceneNavigationController: moviesSceneNavigationController
        )
    }
}

private extension TabBarCoordinator {
    
    func startMoviesScene(
        type: TabBarType,
        moviesSceneNavigationController: UINavigationController
    ) {
        moviesSceneNavigationController.tabBarItem.title = type.title
        moviesSceneNavigationController.tabBarItem.image = type.image
        let moviesSceneDIContainer = dependencies.makeMoviesDIContainer()
        let flow = moviesSceneDIContainer.makeMoviesSceneCoordinator(navigationController: moviesSceneNavigationController)
        flow.start()
        childCoordinators.append(flow)
    }
}
