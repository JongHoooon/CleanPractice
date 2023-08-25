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
    
    func makeImageRepository() -> ImageRepository {
        
        return DefaultImageRepository()
    }
    
    // MARK: - UseCase
    func makeFetchPopularMoviesUseCase() -> FetchPopularMoviesUseCase {
        
        return DefaultFetchPopularMoviesUseCase(
            movieRepository: makeMovieRepository()
        )
    }
    
    
    // MARK: - Movies List View
    func makeMoviesListViewController(actions: MoviesListViewModelActions) -> MoviesListViewController {
        
        return MoviesListViewController(
            viewModel: makeMoviesListViewModel(actions: actions),
            imageRepository: makeImageRepository()
        )
    }
    
    func makeMoviesListViewModel(actions: MoviesListViewModelActions) -> MoviesListViewModel {
        
        return DefaultMoviesListViewModel(
            fetchPopularMoviesUseCase: makeFetchPopularMoviesUseCase(),
            actions: actions
        )
    }
    
    
    // MARK: - Movie Details View
    func makeMovieDetailsViewController(
        actions:MovieDetailViewModelActions,
        id: Int
    ) -> MovieDetailsViewController {
        return MovieDetailsViewController(viewModel: makeMovieDetailsViewModel(actions: actions, id: id))
    }
    
    func makeMovieDetailsViewModel(
        actions: MovieDetailViewModelActions,
        id: Int
    ) -> MovieDetailsViewModel {
        return DefaultMovieDetailsViewModel(
            actions: actions,
            id: id,
            movieRepository: makeMovieRepository(),
            imageRepostiroy: makeImageRepository()
        )
    }
    

}
