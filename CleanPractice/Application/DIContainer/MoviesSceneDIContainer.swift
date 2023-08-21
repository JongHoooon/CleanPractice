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
    func makeMovieRepository() -> MovieRepository {
        
        return DefaultMovieRepository()
    }
    
    // MARK: - UseCase
    func makeFetchPopularMoviesUseCase() -> FetchPopularMoviesUseCase {
        
        return DefaultFetchPopularMoviesUseCase(
            movieRepository: makeMovieRepository()
        )
    }
    
    
    // MARK: - Movies List View
    func makeMoviesListViewModel(actions: MoviesListViewModelActions) -> MoviesListViewModel {
        
        return DefaultMoviesListViewModel(
            fetchPopularMoviesUseCase: makeFetchPopularMoviesUseCase(),
            actions: actions
        )
    }
    
    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> MoviesListViewController {
        
        return MoviesListViewController(viewModel: makeMoviesListViewModel(actions: actions))
    }
}
