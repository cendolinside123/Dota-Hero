//
//  SegmenCollectionViewCell.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import UIKit

class SegmenCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? .white : .black
            self.lblTitle.textColor = isSelected ? .black: .white
        }
    }
    
    private let lblTitle = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        self.backgroundColor = .black
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        setupLayout()
        addConstraints()
    }
    
    private func setupLayout() {
        addLabel()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["lblTitle": lblTitle]
        let metrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        let hLblTitle = "H:|-0-[lblTitle]-0-|"
        let vLblTitle = "V:|-0-[lblTitle]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLblTitle, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vLblTitle, options: .alignAllLeading, metrics: metrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addLabel() {
        lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byTruncatingTail
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.textColor = .white
        lblTitle.backgroundColor = UIColor(white: 1, alpha: 0.5)
        lblTitle.textAlignment = .center
        contentView.addSubview(lblTitle)
    }
    
}
extension SegmenCollectionViewCell {
    func setValue(text value: String) {
        lblTitle.text = value
    }
}
