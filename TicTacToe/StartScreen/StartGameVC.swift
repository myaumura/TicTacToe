//
//  StartGameVC.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 08.04.2024.
//

import UIKit

class StartGameVC: UIViewController {
    
    private var presenter: StartPresenter?
    private let startView: StartGameView?
    
    struct Dependencies {
        let presenter: StartPresenter
    }
    
    init(dependencies: Dependencies) {
        self.startView = StartGameView()
        self.presenter = dependencies.presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        guard let startView = startView else { return }
        presenter?.loadView(controller: self, view: startView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let startView = startView else { return }
        view.addSubview(startView)
        
        NSLayoutConstraint.activate([
            startView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            startView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            startView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            startView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
