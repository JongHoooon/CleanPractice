//
//  MoviesCoordinator.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import UIKit

protocol MoviesListCoordinatorDependencies {
    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> MoviesListViewController
    func makeMovieDetailsViewController(actions: MovieDetailViewModelActions, id: Int) -> MovieDetailsViewController
}

final class MoviesCoordinator: Coordinatorable {
    
    
    #warning("weak로 선언하는 이유??")
    var navigationController: UINavigationController
    var childCoordinators: [Coordinatorable] = []
    var finishDelegate: CoordinatorFinishDelegate?
    private let dependencies: MoviesListCoordinatorDependencies

    
    init(
        navigationController: UINavigationController,
        dependencies: MoviesListCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = MoviesListViewModelActions(showMovieDetails: showMovieDetails)
        let vc = dependencies.makeMoviesListViewController(actions: actions)
        navigationController.pushViewController(vc, animated: true)
    }
}

private extension MoviesCoordinator {
    func showMovieDetails(id: Int) {
        let actions = MovieDetailViewModelActions(closeMovieDetails: closeMovieDetails)
        let vc = dependencies.makeMovieDetailsViewController(actions: actions, id: id)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func closeMovieDetails() {
        navigationController.popViewController(animated: true)
    }
}
