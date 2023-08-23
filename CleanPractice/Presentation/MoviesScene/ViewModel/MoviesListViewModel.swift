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
    let showMovieDetails: (Video) -> Void
}

protocol MoviesListViewModelInput {
    func viewDidLoad()
}

protocol MoviesListViewModelOutput {
    var movieItemsRelay: BehaviorRelay<[Video]> { get }
}

protocol MoviesListViewModel: MoviesListViewModelInput, MoviesListViewModelOutput {}

final class DefaultMoviesListViewModel: MoviesListViewModel {
    
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
    func viewDidLoad() {
        fetchMovies(page: 1)
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
