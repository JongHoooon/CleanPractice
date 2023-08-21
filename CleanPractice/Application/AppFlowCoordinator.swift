//
//  AppFlowCoordinator.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import UIKit

protocol Coordinatorable {
    func start()
}

final class AppFlowCoordinator: Coordinatorable {
    
    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        #warning("로그인 여부 체크")
//        In App Flow we can check if user needs to login, if yes we would run login flow
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer
            .makeMoviesSceneCoordinator(navigationController: navigationController)
        
        flow.start()
    }
}
