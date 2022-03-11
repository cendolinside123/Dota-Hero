//
//  AttackTypeTableViewCell.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class AttackTypeTableViewCell: UITableViewCell {
    
    private var lblName = UILabel()
    private var lblValue = UILabel()
    private let contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 5
        stack.layoutMargins.left = 10
        stack.layoutMargins.right = 10
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    private func setup() {
        self.backgroundColor = .white
        setupLayout()
        addConstraints()
    }
    
    private func addConstraints() {
        let views = ["contentStackView": contentStackView, "lblValue": lblValue, "lblName": lblName]
        let metrix:[String:Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: contentStackView constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let hContentStackView = "H:|-0-[contentStackView]-0-|"
        let vContentStackView = "V:|-0-[contentStackView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentStackView, options: .alignAllLeading, metrics: metrix, views: views)
        
        //MARK: lblName and lblValue constraints
        lblName.translatesAutoresizingMaskIntoConstraints = false
        lblValue.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblValue, attribute: .width, relatedBy: .equal, toItem: lblName, attribute: .width, multiplier: 2/9, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupLayout() {
        addLabelStat()
        addLabelValue()
        addStackView()
    }
    
    private func addLabelStat() {
        lblName.font = UIFont.systemFont(ofSize: 20)
        lblName.numberOfLines = 0
        lblName.lineBreakMode = .byTruncatingTail
        lblName.adjustsFontSizeToFitWidth = true
        lblName.textColor = .black
        lblName.backgroundColor = .white
        lblName.textAlignment = .left
        lblName.text = "Attack Type"
        contentView.addSubview(lblName)
    }
    
    private func addLabelValue() {
        lblValue.font = UIFont.systemFont(ofSize: 15)
        lblValue.numberOfLines = 0
        lblValue.lineBreakMode = .byTruncatingTail
        lblValue.adjustsFontSizeToFitWidth = true
        lblValue.textColor = .gray
        lblValue.backgroundColor = .white
        lblValue.textAlignment = .left
        contentView.addSubview(lblValue)
    }
    
    private func addStackView() {
        contentStackView.addArrangedSubview(lblName)
        contentStackView.addArrangedSubview(lblValue)
        contentView.addSubview(contentStackView)
    }

    
    func addValue(hero: Hero) {
        lblValue.text = hero.attack_type
    }
}

