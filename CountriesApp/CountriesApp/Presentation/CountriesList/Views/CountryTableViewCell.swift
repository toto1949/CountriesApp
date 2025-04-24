//
//  CountryTableViewCell.swift
//  CountriesApp
//
//  Created by Taooufiq El moutaoouakil on 4/24/25.
//

import UIKit

final class CountryTableViewCell: UITableViewCell {
    
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .right
        return label
    }()
    
    private let capitalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        codeLabel.text = nil
        capitalLabel.text = nil
    }
    
    
    func configure(with country: Country) {
        titleLabel.text = country.displayTitle
        codeLabel.text = country.code
        capitalLabel.text = country.capital
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(codeLabel)
        containerView.addSubview(capitalLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: codeLabel.leadingAnchor, constant: -8),
            
            codeLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            codeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            capitalLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            capitalLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            capitalLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            capitalLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
