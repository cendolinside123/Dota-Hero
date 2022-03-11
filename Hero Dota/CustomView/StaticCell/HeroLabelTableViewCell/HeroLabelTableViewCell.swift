//
//  HeroLabelTableViewCell.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class HeroLabelTableViewCell: UITableViewCell {

    private let heroPict = UIImageView()
    private let heroName = UILabel()
    private let heroAttribute = UILabel()
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
    private let heroDetail: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 1
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
    
    private func setupLayout() {
        addImage()
        addLabelName()
        addHerroAttribute()
        addStackView()
    }
    
    private func addConstraints() {
        let views = ["heroPict": heroPict, "contentStackView": contentStackView]
        let metrix:[String:Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: contentStackView constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let hContentStackView = "H:|-0-[contentStackView]-0-|"
        let vContentStackView = "V:|-0-[contentStackView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentStackView, options: .alignAllLeading, metrics: metrix, views: views)
        
        //MARK: heroPict constraints
        heroPict.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: heroPict, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 2/9, constant: 0)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addImage() {
        heroPict.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        heroPict.image = #imageLiteral(resourceName: "loading")
        heroPict.contentMode = .scaleAspectFill
        contentView.addSubview(heroPict)
    }
    
    private func addLabelName() {
        heroName.font = UIFont.systemFont(ofSize: 20)
        heroName.numberOfLines = 0
        heroName.lineBreakMode = .byTruncatingTail
        heroName.adjustsFontSizeToFitWidth = true
        heroName.textColor = .black
        heroName.backgroundColor = .white
        heroName.textAlignment = .left
        contentView.addSubview(heroName)
    }
    
    private func addHerroAttribute() {
        heroAttribute.font = UIFont.systemFont(ofSize: 10)
        heroAttribute.numberOfLines = 0
        heroAttribute.lineBreakMode = .byTruncatingTail
        heroAttribute.adjustsFontSizeToFitWidth = true
        heroAttribute.textColor = .black
        heroAttribute.backgroundColor = .white
        heroAttribute.textAlignment = .left
        contentView.addSubview(heroAttribute)
    }
    private func addStackView() {
        heroDetail.addArrangedSubview(heroName)
        heroDetail.addArrangedSubview(heroAttribute)
        contentView.addSubview(heroDetail)
        contentStackView.addArrangedSubview(heroPict)
        contentStackView.addArrangedSubview(heroDetail)
        contentView.addSubview(contentStackView)
    }
}
extension HeroLabelTableViewCell {
    func setInfo(hero: Hero) {
        heroPict.setImage(url: hero.img)
    
        heroName.text = hero.localized_name
        heroAttribute.text = hero.primary_attr.uppercased()
    }
}

