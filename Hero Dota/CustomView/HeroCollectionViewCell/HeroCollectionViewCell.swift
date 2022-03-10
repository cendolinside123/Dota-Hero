//
//  HeroCollectionViewCell.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 18/01/22.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    private let imageHero = UIImageView()
    private let lblTitle = UILabel()
    private let stackViewContent:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
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
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        addLayouts()
        addConstraints()
    }
    
    private func addLayouts() {
        addImage()
        addTitle()
        addStackView()
    }
    
    private func addConstraints() {
        let views = ["stackViewContent": stackViewContent, "imageHero": imageHero, "lblTitle": lblTitle]
        let metrix:[String:Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        
        //MARK: stackViewContent constraints
        stackViewContent.translatesAutoresizingMaskIntoConstraints = false
        let hStackViewContent = "H:|-0-[stackViewContent]-0-|"
        let vStackViewContent = "V:|-0-[stackViewContent]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hStackViewContent, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vStackViewContent, options: .alignAllLeading, metrics: metrix, views: views)
        
        //MARK: lblTitle and imageHero constraints
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        imageHero.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblTitle, attribute: .height, relatedBy: .equal, toItem: imageHero, attribute: .height, multiplier: 3/7, constant: 0)]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addImage() {
        imageHero.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        imageHero.image = #imageLiteral(resourceName: "loading")
        imageHero.contentMode = .scaleAspectFit
        contentView.addSubview(imageHero)
    }
    
    private func addTitle() {
        lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byTruncatingTail
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.textColor = .black
        lblTitle.backgroundColor = .white
        lblTitle.textAlignment = .center
        contentView.addSubview(lblTitle)
    }
    
    private func addStackView() {
        stackViewContent.addArrangedSubview(imageHero)
        stackViewContent.addArrangedSubview(lblTitle)
        contentView.addSubview(stackViewContent)
    }
}

extension HeroCollectionViewCell {
    func setProduct(hero: Hero) {
        lblTitle.text = hero.localized_name
        imageHero.setImage(url: hero.img)
        if hero.isFavorite {
            self.backgroundColor = .yellow
            lblTitle.backgroundColor = .yellow
            imageHero.backgroundColor = .yellow
        } else {
            self.backgroundColor = .white
            lblTitle.backgroundColor = .white
            imageHero.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        }
    }
    
    func getImage() -> UIImageView {
        return imageHero
    }
    
}
