//
//  AppDIContainer.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - DIContainers of scene
    func makeTabBarSceneDIContainer() -> TabBarSceneDIContainer {
        return TabBarSceneDIContainer()
    }
    
    func makeAuthSceneDIContainer() -> AuthSceneDIContainer {
        return AuthSceneDIContainer()
    }
}
