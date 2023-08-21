//
//  MoviesCoordinator.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import UIKit

protocol MoviesListCoordinatorDependencies {
    func makeMoviesListViewController() -> MoviesListViewController
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
        let vc = dependencies.makeMoviesListViewController()
        navigationController?.pushViewController(vc, animated: false)
        moiesListVC = vc
    }
}
