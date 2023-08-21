//
//  MoviesListViewModel.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Foundation

struct MoviesListViewModelActions {
    let showMovieDetails: (Video) -> Void
}

protocol MoviesListViewModelInput {}

protocol MoviesListViewModelOutput {}

protocol MoviesListVIewModel: MoviesListViewModelInput, MoviesListViewModelOutput {}

final class DefaultMoviesListViewModel: MoviesListVIewModel {
    
    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
#warning("let으로 할건데 왜 opional로 ???? ")
    private let actions: MoviesListViewModelActions?
    
    private var page: [VideosPage] = []

    // MARK: - Init
    
    init(
        fetchPopularMoviesUseCase: FetchPopularMoviesUseCase,
        actions: MoviesListViewModelActions
    ) {
        self.fetchPopularMoviesUseCase = fetchPopularMoviesUseCase
        self.actions = actions
    }
    
    // MARK: - Input
    
    // MARK: - Output
    
        
    
}
