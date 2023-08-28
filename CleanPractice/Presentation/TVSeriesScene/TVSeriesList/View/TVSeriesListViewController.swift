//
//  TVSeriesListViewController.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/28.
//

import UIKit

import RxSwift
import RxCocoa

final class TVSeriesListViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: TVSeriesListViewModel
    private let imageRepository: ImageRepository
    private let disposeBag = DisposeBag()
    
    // MARK: - UI
    private let logoutTabBarButton = UIBarButtonItem(
        image: ImageSpace.Icon.logout,
        style: .plain,
        target: nil,
        action: nil
    )
    
    // MARK: - Init
    init(
        viewModel: TVSeriesListViewModel,
        imageRepository: ImageRepository
    ) {
        self.viewModel = viewModel
        self.imageRepository = imageRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bind()
    }
}

// MARK: - Bind
private extension TVSeriesListViewController {
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        logoutTabBarButton.rx.tap
            .bind(
                with: self,
                onNext: { owner, _ in
                    owner.showLogoutAlert()
                }
            )
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {}
}

// MARK: - Private
private extension TVSeriesListViewController {
    
    func showLogoutAlert() {
        let alertController = UIAlertController(
            title: nil,
            message: "정말로 로그아웃하시겠습니까?",
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(
            title: "확인",
            style: .default,
            handler: { [weak self] _ in
                self?.viewModel.logout()
            }
        )
        let cancelAction = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        [
            confirmAction,
            cancelAction
        ].forEach { alertController.addAction($0) }
        
        present(alertController, animated: true)
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "TV"
        navigationItem.rightBarButtonItem = logoutTabBarButton
    }
}
