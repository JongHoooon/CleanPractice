//
//  TVSeriesListViewModel.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

import Foundation

#warning("alert는 어떻게??")
struct TVSeriesListViewModelActions {
    let showLogin: () -> Void
}

protocol TVSeriesListViewModelInput {
    func logout()
}

protocol TVSeriesListViewModelOutput {}

protocol TVSeriesListViewModel: TVSeriesListViewModelInput, TVSeriesListViewModelOutput {}

final class DefaultTVSeriesListViewModel: TVSeriesListViewModel {
    
    // MARK: - Properties
    private let actions: TVSeriesListViewModelActions
    private let fetchPopularTVSeriesUseCase: FectchPopularTVSeriesUseCase
    
    // MARK: - Init
    init(
        actions: TVSeriesListViewModelActions,
        fetchPopularTVSeriesUseCase: FectchPopularTVSeriesUseCase
    ) {
        self.actions = actions
        self.fetchPopularTVSeriesUseCase = fetchPopularTVSeriesUseCase
    }
    
    // MARK: - Input
    func logout() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoggedIn.key)
        actions.showLogin()
    }
}

