//
//  TabBarCoordinator.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/27.
//

import UIKit

#warning("TabBar 로 화면 전환시에는 root view를 바꿔주는게 맞지 않을까??")
protocol TabBarCoordinatorDependencies {
    func makeTabBarController() -> UITabBarController
    func makeMoviesDIContainer() -> MoviesSceneDIContainer
    func makeTVSeriesDIContainer() -> TVSeriesDIContainer
}

protocol TabBarCoordinatorDelegate: AnyObject {
    func showLoginView()
}

final class TabBarCoordinator: Coordinatorable {
    
    private let dependencies: TabBarCoordinatorDependencies
    var childCoordinators: [Coordinatorable] = []
    var finishDelegate: CoordinatorFinishDelegate?
    weak var delegate: TabBarCoordinatorDelegate?
    
    init(
        dependencies: TabBarCoordinatorDependencies
    ) {
        self.dependencies = dependencies
    }
    
    func start() {
        let tabBarController = dependencies.makeTabBarController()
        tabBarController.tabBar.tintColor = .label
        
        showTabBar(tabBar: tabBarController)
        
        let moviesSceneNavigationController = UINavigationController()
        let tvSeriesSceneNavigationController = UINavigationController()
        
        tabBarController.viewControllers = [
            moviesSceneNavigationController,
            tvSeriesSceneNavigationController
        ]
        
        startMoviesScene(moviesSceneNavigationController: moviesSceneNavigationController)
        startTVSeriesScene(tvSeriesSceneNavigationController: tvSeriesSceneNavigationController)
    }
}

private extension TabBarCoordinator {
    
    func startMoviesScene(
        moviesSceneNavigationController: UINavigationController
    ) {
        let type = TabBarType.movies
        moviesSceneNavigationController.tabBarItem.title = type.title
        moviesSceneNavigationController.tabBarItem.image = type.image
        let moviesSceneDIContainer = dependencies.makeMoviesDIContainer()
        let flow = moviesSceneDIContainer.makeMoviesSceneCoordinator(navigationController: moviesSceneNavigationController)
        flow.start()
        childCoordinators.append(flow)
    }
    
    func startTVSeriesScene(
        tvSeriesSceneNavigationController: UINavigationController
    ) {
        let type = TabBarType.tvSeries
        tvSeriesSceneNavigationController.tabBarItem.title = type.title
        tvSeriesSceneNavigationController.tabBarItem.image = type.image
        let tvSeriesSceneDIContainer = dependencies.makeTVSeriesDIContainer()
        let flow = tvSeriesSceneDIContainer.makeTVSeriesSceneCoordinator(navigationController: tvSeriesSceneNavigationController)
        flow.delegate = self
        flow.start()
        childCoordinators.append(flow)
    }
    
    func showTabBar(tabBar: UITabBarController) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = tabBar
        sceneDelegate?.window?.makeKeyAndVisible()
        
        guard let window = sceneDelegate?.window else { return }
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: [.transitionCrossDissolve],
            animations: nil
        )
    }
}

extension TabBarCoordinator: TVSeriesCoordinatorDelegate {
    func showLoginView() {
        delegate?.showLoginView()
    }
}
