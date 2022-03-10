//
//  DetailViewController.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class DetailViewController: UIViewController {

    private let tblInfoDetail: UITableView = {
        let tabel = UITableView()
        tabel.backgroundColor = .white
        tabel.allowsSelection = false
        tabel.tableFooterView = UIView()
        return tabel
    }()
    private var getHero: Hero?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = ""
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Dota 2", style: .done, target: self, action: #selector(exit(sender: )))
        self.view.backgroundColor = .white
        addLayout()
        addConstraints()
        setupTabel()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func addLayout() {
        addTabel()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["tblInfoDetail": tblInfoDetail]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        // MARK: tblInfoDetail constraints
        tblInfoDetail.translatesAutoresizingMaskIntoConstraints = false
        let hTblMenu = "H:|-[tblInfoDetail]-|"
        let vTblMenu = "V:|-0-[tblInfoDetail]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTblMenu, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vTblMenu, options: .alignAllLeading, metrics: metrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func addTabel() {
        view.addSubview(tblInfoDetail)
    }
    
    private func setupTabel() {
        tblInfoDetail.delegate = self
        tblInfoDetail.dataSource = self
        tblInfoDetail.register(BicPictTableViewCell.self, forCellReuseIdentifier: "BigPicCell")
    }

}
extension DetailViewController {
    
    func setDetail(hero: Hero) {
        getHero = hero
        self.navigationItem.title = hero.localized_name
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        tblInfoDetail.reloadData()
    }
    
    @objc private func exit(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if getHero == nil {
            return 0
        }
        
        if section == 0 {
            return 1
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if getHero == nil {
            return 0
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if getHero == nil {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "BigPicCell", for: indexPath) as? BicPictTableViewCell else {
                    return UITableViewCell()
                }
                if let checkHero = getHero {
                    cell.setPic(hero: checkHero)
                    return cell
                } else {
                    return UITableViewCell()
                }
            } else {
                return UITableViewCell()
            }
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if getHero == nil {
            return 0
        }
        
        if indexPath.section == 0 {
            return 250
        } else {
            return 0
        }
    }
}
