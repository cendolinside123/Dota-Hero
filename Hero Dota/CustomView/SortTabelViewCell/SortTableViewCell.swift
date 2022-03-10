//
//  SortTableViewCell.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class SortTableViewCell: UITableViewCell {
    
    
    private let lblTitle = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = .white
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
        let hLblTitle = "H:|-[lblTitle]-|"
        let vLblTitle = "V:|-[lblTitle]-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLblTitle, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vLblTitle, options: .alignAllLeading, metrics: metrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addLabel() {
        lblTitle.font = UIFont.systemFont(ofSize: 15)
        lblTitle.numberOfLines = 0
        lblTitle.lineBreakMode = .byTruncatingTail
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.textColor = .black
//        lblTitle.backgroundColor = .white
        lblTitle.textAlignment = .left
        contentView.addSubview(lblTitle)
    }
    

}
extension SortTableViewCell {
    func setValue(text sort: Sort) {
        lblTitle.text = sort.rawValue
    }
}
