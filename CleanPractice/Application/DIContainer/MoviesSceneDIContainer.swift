//
//  MoviesSceneDIContainer.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import UIKit

#warning("Struct VS Class ??")
struct MoviesSceneDIContainer {
    
    func makeMoviesSceneCoordinator(
        navigationController: UINavigationController
    ) -> MoviesCoordinator {
        return MoviesCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}

extension MoviesSceneDIContainer: MoviesListCoordinatorDependencies {
    
    // MARK: - Repository
    
    // MARK: - UseCase
    
    // MARK: - Movies List View
    func makeMoviesListViewController() -> MoviesListViewController {
        return MoviesListViewController()
    }
    
}
