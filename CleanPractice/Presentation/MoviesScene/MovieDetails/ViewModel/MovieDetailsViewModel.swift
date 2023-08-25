//
//  MovieDetailsViewModel.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/23.
//

import Foundation

#warning("actions 프로퍼티 명 show 보다는 present, push, pop로 좀더 명시적으로 해주면 어떨지?")

struct MovieDetailViewModelActions {
    let closeMovieDetails: () -> Void
}

protocol MovieDetailsViewModelInput {
    func backButtonTapped()
}

protocol MovieDetailsViewModelOutput {
    
}

protocol MovieDetailsViewModel: MovieDetailsViewModelInput, MovieDetailsViewModelOutput {}

final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    
    private let actions: MovieDetailViewModelActions
    private let id: Int
    
    init(
        actions: MovieDetailViewModelActions,
        id: Int
    ) {
        self.actions = actions
        self.id = id
    }
}

extension DefaultMovieDetailsViewModel {
    
    // MARK: - Input
    func backButtonTapped() {
        actions.closeMovieDetails()
    }
    
}
