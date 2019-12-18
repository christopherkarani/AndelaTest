//
//  EntryCell.swift
//  andela
//
//  Created by Chris Karani on 12/18/19.
//  Copyright © 2019 Chris Karani. All rights reserved.
//

import UIKit

class EntryCell : UICollectionViewCell {
    static var cellID = "EntriesCellID"
    
    var entry: Entry? {
        didSet {
            guard let entry = entry else { return }
            apiLabel.text = "API: \(entry.api)"
            descriptionLabel.text = "Description: \(entry.description)"
            authLabel.text = "Auth: \(entry.auth)"
            httpsLabel.text = "HTTPS: \(entry.https)"
            corsLabel.text = "Cors: \(entry.cors)"
            linkLabel.text = "Link: \(entry.link)"
            categoryLabel.text = "Category: \(entry.category)"
        }
    }
    
    let apiLabel = UILabel()
    let descriptionLabel = UILabel()
    let authLabel = UILabel()
    let httpsLabel = UILabel()
    let corsLabel = UILabel()
    let linkLabel = UILabel()
    let categoryLabel = UILabel()
    
    var seperatorLine : SeparatorLine = {
        let line = SeparatorLine()
        line.backgroundColor = .black
        return line
    }()
    
    lazy var labels = [seperatorLine, apiLabel, descriptionLabel, authLabel, httpsLabel, corsLabel, linkLabel, categoryLabel]
    
    lazy var labelStack : UIStackView = {
         let stack = UIStackView(arrangedSubviews: labels)
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .blue
        return stack 
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupLabels()
        let stackViewContainer = UIView()
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackViewContainer)
        contentView.addSubview(seperatorLine)
        
        
        // seperator line constraints
        NSLayoutConstraint.activate([
            seperatorLine.topAnchor.constraint(equalTo: topAnchor),
            seperatorLine.widthAnchor.constraint(equalTo: widthAnchor),
            seperatorLine.heightAnchor.constraint(equalToConstant: 1),
            seperatorLine.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])

        
        // label stack contraints
        NSLayoutConstraint.activate([
            stackViewContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewContainer.widthAnchor.constraint(equalTo: widthAnchor),
            stackViewContainer.heightAnchor.constraint(equalTo: heightAnchor),
            stackViewContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        stackViewContainer.addSubview(labelStack)
        
        NSLayoutConstraint.activate([
            labelStack.leftAnchor.constraint(equalTo: stackViewContainer.leftAnchor),
            labelStack.rightAnchor.constraint(equalTo: stackViewContainer.rightAnchor),
            labelStack.topAnchor.constraint(equalTo: stackViewContainer.topAnchor),
            labelStack.bottomAnchor.constraint(equalTo: stackViewContainer.bottomAnchor)
        ])
        
        
    }
    
    fileprivate func setupLabels() {
        labels.forEach { view in
            guard let label = view as? UILabel else { return }
            label.backgroundColor = UIColor.init(white: 0.92, alpha: 1)
            label.font = UIFont.boldSystemFont(ofSize: 14)
            label.numberOfLines = 0
        }
        

    }
    
    private func setupUI() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
