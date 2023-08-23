//
//  MoviesListViewController.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/21.
//

import UIKit

import RxCocoa
import RxSwift

final class MoviesListViewController: UIViewController {
    
    // MARK: - Property
    private let viewModel: MoviesListViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI
    private let movieTableView: VideosListTableView = {
        let tableView = VideosListTableView()
        
        return tableView
    }()
    
    // MARK: - Init
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        bind()
        viewModel.viewDidLoad()
        
        navigationItem.title = "인기 영화"
    }
}

// MARK: - Bind
extension MoviesListViewController {
    
    private func bind() {
        bindIntput()
        bindOutput()
    }
    
    private func bindIntput() {
        
    }
    
    private func bindOutput() {
        
        viewModel.movieItemsRelay
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: movieTableView.rx.items(
                cellIdentifier: MoviesListItemCell.identifier,
                cellType: MoviesListItemCell.self
            )) { (index, element, cell) in
                cell.bind(viewModel: MoviesListItemViewModel(movie: element))
            }
            .disposed(by: disposeBag)
    }
}

private extension MoviesListViewController {
    
    func configureLayout() {

        view.addSubview(movieTableView)
        
        movieTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
