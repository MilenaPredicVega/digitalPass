//
//  TableViewCell.swift
//  DigitalPassaport
//
//  Created by Milena Predic on 18.8.23..
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.textBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.backroundItem
        layer.cornerRadius = 10
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
    setUpSubviews()
        
        NSLayoutConstraint.activate([
            cellImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cellImageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            cellImageView.widthAnchor.constraint(equalToConstant: 60),
            cellImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 12),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            statusLabel.leadingAnchor.constraint(equalTo: cellImageView.trailingAnchor, constant: 12),
            statusLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 4),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            statusLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
    
    private func setUpSubviews() {
        addSubview(cellImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(statusLabel)
    }
    
    func configure(with data: Pass) {
        selectionStyle = .none
        titleLabel.text = data.name
    // TODO: replace with the status indicator
        statusLabel.text = "Test"
        descriptionLabel.text = data.description
        
        if let iconBase64 = data.icon, let iconData = Data(base64Encoded: iconBase64), let iconImage = UIImage(data: iconData) {
            cellImageView.image = iconImage
        } else {
            cellImageView.image = UIImage(systemName: "heart.fill")
        }
    }
}





