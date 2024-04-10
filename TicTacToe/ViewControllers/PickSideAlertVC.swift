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
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    
    private let leftButton = AlertButton(backgroundColor: .systemPink, title: "")
    private let rightButton = AlertButton(backgroundColor: .systemPink, title: "")
    
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
    var leftButtonTitle: String?
    var rightButtonTitle: String?
    
    
    init(title: String, message: String, leftButtonTitle: String, rightButtonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonTitle = rightButtonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        addSubviews()
        setupConstraints()
        setupView()
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

private extension PickSideAlertVC {
    private func addSubviews() {
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(stackView)
        containerView.addSubview(messageLabel)
        stackView.addArrangedSubview(leftButton)
        stackView.addArrangedSubview(rightButton)
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 88),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -12)
        ])
    }
    
    private func setupView() {
 
        messageLabel.text = message
        messageLabel.numberOfLines = 4
        titleLabel.text = alertTitle
        
        leftButton.setTitle(leftButtonTitle, for: .normal)
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        leftButton.addTarget(self, action: #selector(chooseX), for: .touchUpInside)
        
        rightButton.setTitle(rightButtonTitle, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        rightButton.addTarget(self, action: #selector(chooseO), for: .touchUpInside)
    }
}
