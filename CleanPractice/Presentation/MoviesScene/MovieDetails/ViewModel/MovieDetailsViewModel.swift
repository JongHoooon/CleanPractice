//
//  MovieDetailsViewModel.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/23.
//

import Foundation

import RxRelay

#warning("actions 프로퍼티 명 show 보다는 present, push, pop로 좀더 명시적으로 해주면 어떨지?")

struct MovieDetailViewModelActions {
    let closeMovieDetails: () -> Void
}

protocol MovieDetailsViewModelInput {
    func viewDidLoad()
    func backButtonTapped()
}

protocol MovieDetailsViewModelOutput {
    var backdropImageDataRelay: PublishRelay<Data> { get }
    var posterImageDataRelay: PublishRelay<Data> { get }
    var titleRelay: PublishRelay<String> { get }
    var runtimeRelay: PublishRelay<String> { get }
    var voteAverageRelay: PublishRelay<String> { get }
    var overviewRelay: PublishRelay<String> { get }
}

protocol MovieDetailsViewModel: MovieDetailsViewModelInput, MovieDetailsViewModelOutput {}

final class DefaultMovieDetailsViewModel: MovieDetailsViewModel {
    
    private let actions: MovieDetailViewModelActions
    private let id: Int
    private let fetchMovieDetailsUseCase: FetchMovieDetailsUseCase
    private let imageRepository: ImageRepository
    
    init(
        actions: MovieDetailViewModelActions,
        id: Int,
        fetchMovieDetailsUseCase: FetchMovieDetailsUseCase,
        imageRepostiroy: ImageRepository
    ) {
        self.actions = actions
        self.id = id
        self.fetchMovieDetailsUseCase = fetchMovieDetailsUseCase
        self.imageRepository = imageRepostiroy
    }
    
    // MARK: - Input
    func viewDidLoad() {
        Task {
            do {
                let movieDetail = try await fetchMovieDetailsUseCase.execute(id: id)
                Task {
                    let backdropImageData = try await imageRepository.fetchImage(imagePath: movieDetail.backdropPath ?? "")
                    backdropImageDataRelay.accept(backdropImageData)
                }
                Task {
                    let posterImageData = try await imageRepository.fetchImage(imagePath: movieDetail.posterPath ?? "")
                    posterImageDataRelay.accept(posterImageData)
                }
                titleRelay.accept(movieDetail.title ?? "제목이 존재하지 않습니다.")
                runtimeRelay.accept("\(movieDetail.runtime ?? 0)" + "분")
                voteAverageRelay.accept(
                   "⭐️ " + String(format: "%.1f", movieDetail.voteAverage ?? 0)
                )
                overviewRelay.accept(movieDetail.overView ?? "줄거리가 존재하지 않습니다.")
            } catch {
                print(error)
            }
        }
    }
    
    func backButtonTapped() {
        actions.closeMovieDetails()
    }
    
    // MARK: - Output
    var backdropImageDataRelay: PublishRelay<Data> = .init()
    var posterImageDataRelay: PublishRelay<Data> = .init()
    var titleRelay: PublishRelay<String> = .init()
    var runtimeRelay: PublishRelay<String> = .init()
    var voteAverageRelay: PublishRelay<String> = .init()
    var overviewRelay: PublishRelay<String> = .init()
}
