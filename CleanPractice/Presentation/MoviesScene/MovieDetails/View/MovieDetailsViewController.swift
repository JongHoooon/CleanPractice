//
//  MovieDetailsViewController.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/23.
//

import UIKit

import RxSwift
import RxCocoa

final class MovieDetailsViewController: UIViewController {

    // MARK: - Properties
    private let viewModel: MovieDetailsViewModel
    private let disposebag = DisposeBag()
    
    // MARK: - UI
    private let popBarButton = UIBarButtonItem(
        image: ImageSpace.chevronLeft,
        style: .plain,
        target: nil,
        action: nil
    )
    
    // MARK: - Init
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configure()
        bind()
    }
}

// MARK: - Bind
private extension MovieDetailsViewController {
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        popBarButton.rx.tap
            .bind(
                with: self,
                onNext: { owner, _ in
                    owner.viewModel.backButtonTapped()
                }
            )
            .disposed(by: disposebag)
    }
    
    func bindOutput() {
        
    }
}

// MARK: - Private
private extension MovieDetailsViewController {
    
    func configure() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationItem.leftBarButtonItem = popBarButton
    }
}
