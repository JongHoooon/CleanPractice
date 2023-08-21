//
//  MoviesCoordinator.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import UIKit

protocol MoviesListCoordinatorDependencies {
    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> MoviesListViewController
}

final class MoviesCoordinator: Coordinatorable {

    #warning("weak로 선언하는 이유??")
    private weak var navigationController: UINavigationController?
    private let dependencies: MoviesListCoordinatorDependencies
    
    private weak var moiesListVC: MoviesListViewController?
    
    init(
        navigationController: UINavigationController? = nil,
        dependencies: MoviesListCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = MoviesListViewModelActions(showMovieDetails: showMovieDetailsViewController)
        let vc = dependencies.makeMoviesListViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: false)
        moiesListVC = vc
    }
}

extension MoviesCoordinator {
    func showMovieDetailsViewController(video: Video) {
        
    }
}
