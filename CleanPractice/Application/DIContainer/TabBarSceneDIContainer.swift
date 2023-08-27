//
//  TabBarSceneDIContainer.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/27.
//

import UIKit

struct TabBarSceneDIContainer {
    func makeTabBarFlowCoordinator(navigationController: UINavigationController) -> TabBarCoordinator {
        return TabBarCoordinator(
            dependencies: self,
            navigationController: navigationController
        )
    }
}

extension TabBarSceneDIContainer: TabBarCoordinatorDependencies {
    func makeTabBarController() -> UITabBarController {
        return UITabBarController()
    }
    
    func makeMoviesDIContainer() -> MoviesSceneDIContainer {
        return MoviesSceneDIContainer()
    }
}
