//
//  BicPictTableViewCell.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class BicPictTableViewCell: UITableViewCell {

    private let bigPict = UIImageView()
    
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
        addBigPict()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["bigPict": bigPict]
        let metrix: [String: Any] = [:]
        
        var constraints = [NSLayoutConstraint]()
        bigPict.translatesAutoresizingMaskIntoConstraints = false
        let hLblTitle = "H:|-[bigPict]-|"
        let vLblTitle = "V:|-[bigPict]-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLblTitle, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vLblTitle, options: .alignAllLeading, metrics: metrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addBigPict() {
        bigPict.backgroundColor = UIColor(red: 0.87, green: 0.87, blue: 0.87, alpha: 1)
        bigPict.image = #imageLiteral(resourceName: "loading")
        bigPict.contentMode = .scaleAspectFit
        contentView.addSubview(bigPict)
    }

}
extension BicPictTableViewCell {
    func setPic(hero: Hero) {
        bigPict.setBigImage(url: hero.img)
    }
}
