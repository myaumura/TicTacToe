//
//  PickSideAlertVC.swift
//  TicTacToe
//
//  Created by Kirill Gusev on 07.04.2024.
//

import UIKit

protocol PickSideAlertVCDelegate: AnyObject {
    func startWithX()
    func startWithO()
}

class PickSideAlertVC: UIViewController {

    weak var delegate: PickSideAlertVCDelegate?
    
    private let containerView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.90
        label.lineBreakMode = .byTruncatingTail
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.75
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        button.setTitle("OK", for: .normal)
        return button
    }()
    
    let firstActionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        button.setTitle("OK", for: .normal)
        return button
    }()
    
    let secondActionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemPink
        button.setTitle("OK", for: .normal)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    var firstButtonTitle: String?
    var secondButtonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, firstButtonTitle: String, secondButtonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.firstButtonTitle = firstButtonTitle
        self.secondButtonTitle = secondButtonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureTwoActionButtons()
        configureMessageLabel()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureTwoActionButtons() {
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(firstActionButton)
        stackView.addArrangedSubview(secondActionButton)
        firstActionButton.setTitle(firstButtonTitle, for: .normal)
        firstActionButton.addTarget(self, action: #selector(chooseX), for: .touchUpInside)
        
        secondActionButton.setTitle(secondButtonTitle, for: .normal)
        secondActionButton.addTarget(self, action: #selector(chooseO), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 88),
        ])
    }
    
    func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -12)
        ])
    }
    
    @objc func chooseX() {
        delegate?.startWithX()
        dismiss(animated: true)
    }
    
    @objc func chooseO() {
        delegate?.startWithO()
        dismiss(animated: true)
    }
}
