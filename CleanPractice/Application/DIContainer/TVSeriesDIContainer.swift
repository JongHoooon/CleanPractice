//
//  TVSeriesDIContainer.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

struct TVSeriesDIContainer {
    func makeTVSeriesSceneCoordinator(
        navigationController: UINavigationController
    ) -> TVSeriesCoordinator {
        return TVSeriesCoordinator(
            navigationController: navigationController,
            dependencies: self
        )
    }
}

extension TVSeriesDIContainer: TVSeriesCoordinatorDependencies {

    // MARK: - Repository
    func makeTVSeriesRepository() -> TVSeriesRepository {
        return DefaultTVSeriesRepository()
    }
    
    func makeImageRepository() -> ImageRepository {
        return DefaultImageRepository()
    }
    
    // MARK: - UseCase
    func makeFetchPopularTVSeriesUseCase() -> FectchPopularTVSeriesUseCase {
        return DefaultFectchPopularTVSeriesUseCase(
            tvSeriesRepository: makeTVSeriesRepository()
        )
    }
    
    // MARK: - TVSeries ViewController
    func makeTVSeriesViewController(actions: TVSeriesListViewModelActions) -> TVSeriesListViewController {
        return TVSeriesListViewController(
            viewModel: makeTVSeriesViewModel(actions: actions),
            imageRepository: makeImageRepository()
        )
    }
    
    func makeTVSeriesViewModel(actions: TVSeriesListViewModelActions) -> TVSeriesListViewModel {
        return DefaultTVSeriesListViewModel(
            actions: actions,
            fetchPopularTVSeriesUseCase: makeFetchPopularTVSeriesUseCase()
        )
    }
    
    // MARK: - LoginViewController
    #warning("로그인 뷰로 이동을 여기서 시키는게 맞을지??")
    func makeLoginViewController(actions: LoginViewModelActions) -> LoginViewController {
        return LoginViewController(viewModel: makeLoginViewModel(actions: actions))
    }
    
    func makeLoginViewModel(actions: LoginViewModelActions) -> LoginViewModel {
        return DefaultLoginViewModel(actions: actions)
    }
}
