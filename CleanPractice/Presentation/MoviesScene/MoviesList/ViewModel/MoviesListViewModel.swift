//
//  MoviesListViewModel.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Foundation

import RxCocoa
import RxSwift

struct MoviesListViewModelActions {
    let showMovieDetails: (Int) -> Void
}

protocol MoviesListViewModelInput {
    func viewDidLoad()
    func didSelectItem(id: Int)
}

protocol MoviesListViewModelOutput {
    var movieItemsRelay: BehaviorRelay<[Video]> { get }
}

protocol MoviesListViewModel: MoviesListViewModelInput, MoviesListViewModelOutput {}

final class DefaultMoviesListViewModel: MoviesListViewModel {
    
    private let fetchPopularMoviesUseCase: FetchPopularMoviesUseCase
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
    func viewDidLoad() {
        fetchMovies(page: 1)
    }
    
    func didSelectItem(id: Int) {
        actions?.showMovieDetails(id)
    }
    
    // MARK: - Output
    var movieItemsRelay = BehaviorRelay<[Video]>(value: [])
}

private extension DefaultMoviesListViewModel {
    
    func fetchMovies(page: Int) {
        Task {
            do {
                let videosPage = try await fetchPopularMoviesUseCase.execute(page: 1)
                movieItemsRelay.accept(videosPage.videos)
            } catch {
                print(error)
            }
        }
    }
}
