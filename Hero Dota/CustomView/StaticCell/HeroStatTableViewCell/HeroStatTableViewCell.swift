//
//  HeroStatTableViewCell.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class HeroStatTableViewCell: UITableViewCell {

    private var statIcon = UIImageView()
    private var lblStat = UILabel()
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
        let views = ["statIcon": statIcon, "contentStackView": contentStackView, "lblValue": lblValue]
        let metrix:[String:Any] = [:]
        var constraints = [NSLayoutConstraint]()
        
        //MARK: contentStackView constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        let hContentStackView = "H:|-0-[contentStackView]-0-|"
        let vContentStackView = "V:|-0-[contentStackView]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hContentStackView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vContentStackView, options: .alignAllLeading, metrics: metrix, views: views)
        
        //MARK: statIcon constraints
        statIcon.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: statIcon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)]
        
        //MARK: lblValue constraints
        lblValue.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: lblValue, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 80)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupLayout() {
        addImage()
        addLabelStat()
        addLabelValue()
        addStackView()
    }
    
    private func addImage() {
        statIcon.backgroundColor = .white
        statIcon.image = #imageLiteral(resourceName: "loading")
        statIcon.contentMode = .scaleAspectFill
        contentView.addSubview(statIcon)
    }
    
    private func addLabelStat() {
        lblStat.font = UIFont.systemFont(ofSize: 20)
        lblStat.numberOfLines = 0
        lblStat.lineBreakMode = .byTruncatingTail
        lblStat.adjustsFontSizeToFitWidth = true
        lblStat.textColor = .black
        lblStat.backgroundColor = .white
        lblStat.textAlignment = .left
        contentView.addSubview(lblStat)
    }
    
    private func addLabelValue() {
        lblValue.font = UIFont.systemFont(ofSize: 20)
        lblValue.numberOfLines = 0
        lblValue.lineBreakMode = .byTruncatingTail
        lblValue.adjustsFontSizeToFitWidth = true
        lblValue.textColor = .gray
        lblValue.backgroundColor = .white
        lblValue.textAlignment = .center
        contentView.addSubview(lblValue)
    }
    
    private func addStackView() {
        contentStackView.addArrangedSubview(statIcon)
        contentStackView.addArrangedSubview(lblStat)
        contentStackView.addArrangedSubview(lblValue)
        contentView.addSubview(contentStackView)
    }
    
}
extension HeroStatTableViewCell {
    func setStat(hero:Hero, stat type: Sort) {
        if type == .B_Spd {
            statIcon.image = #imageLiteral(resourceName: "speed")
            lblStat.text = "Base Speed"
            lblValue.text = "\(hero.move_speed)"
        } else if type == .B_MP {
            statIcon.image = #imageLiteral(resourceName: "mana")
            lblStat.text = "Base Mana"
            lblValue.text = "\(hero.base_mana)"
        } else if type == .B_HP {
            statIcon.image = #imageLiteral(resourceName: "health")
            lblStat.text = "Base Health"
            lblValue.text = "\(hero.base_health)"
        } else if type == .B_Attk {
            statIcon.image = #imageLiteral(resourceName: "attack")
            lblStat.text = "Base Attack"
            lblValue.text = "\(hero.base_attack_min) - \(hero.base_attack_max)"
        } else if type == .B_Deff {
            statIcon.image = #imageLiteral(resourceName: "armor")
            lblStat.text = "Base Armor"
            lblValue.text = "\(hero.base_armor)"
        } else {
            statIcon.image = #imageLiteral(resourceName: "loading")
            lblValue.text = ""
        }
    }
}
