//
//  TabBarSceneDIContainer.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/27.
//

import UIKit

struct TabBarSceneDIContainer {
    func makeTabBarFlowCoordinator() -> TabBarCoordinator {
        return TabBarCoordinator(
            dependencies: self
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
    
    func makeTVSeriesDIContainer() -> TVSeriesDIContainer {
        return TVSeriesDIContainer()
    }
}
