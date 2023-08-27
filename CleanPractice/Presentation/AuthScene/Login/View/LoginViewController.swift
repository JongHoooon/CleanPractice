//
//  LoginViewController.swift
//  CleanPractice
//
//  Created by JongHoon on 2023/08/27.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: LoginViewModel
    private let disposeBag = DisposeBag()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인 완료!", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGreen
        button.titleLabel?.font = .systemFont(ofSize: 17.0, weight: .medium)
        return button
    }()
    
    // MARK: - Init
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        bind()
    }
}

// MARK: - Bind
private extension LoginViewController {
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        loginButton.rx.tap
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.viewModel.loginButtonTapped()
                }
            )
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {}
    
}

// MARK: - Private
private extension LoginViewController {
    
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "로그인"
    }
    
    func configureLayout() {
        [
            loginButton
        ].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
