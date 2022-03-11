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
        tabel.backgroundColor = .gray
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
        let hTblMenu = "H:|-1-[tblInfoDetail]-1-|"
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
        tblInfoDetail.register(HeroLabelTableViewCell.self, forCellReuseIdentifier: "HeroLabelCell")
        tblInfoDetail.register(AttackTypeTableViewCell.self, forCellReuseIdentifier: "AttackTypeCell")
        tblInfoDetail.register(HeroStatTableViewCell.self, forCellReuseIdentifier: "StatCell")
        tblInfoDetail.register(SortTableViewCell.self, forCellReuseIdentifier: "HeroTypeCell")
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
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 4
        } else if section == 4 {
            return 1
        } else if section == 5 {
            return getHero?.roles.count ?? 0
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if getHero == nil {
            return 0
        }
        
        return 6
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
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroLabelCell", for: indexPath) as? HeroLabelTableViewCell else {
                    return UITableViewCell()
                }
                if let checkHero = getHero {
                    cell.setInfo(hero: checkHero)
                    return cell
                } else {
                    return UITableViewCell()
                }
                
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "AttackTypeCell", for: indexPath) as? AttackTypeTableViewCell else {
                    return UITableViewCell()
                }
                if let checkHero = getHero {
                    cell.addValue(hero: checkHero)
                    return cell
                } else {
                    return UITableViewCell()
                }
                
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatCell", for: indexPath) as? HeroStatTableViewCell else {
                return UITableViewCell()
            }
            if indexPath.row == 0 {
                if let checkHero = getHero {
                    cell.setStat(hero: checkHero, stat: .B_HP)
                    return cell
                } else {
                    return UITableViewCell()
                }
            } else if indexPath.row == 1 {
                if let checkHero = getHero {
                    cell.setStat(hero: checkHero, stat: .B_MP)
                    return cell
                } else {
                    return UITableViewCell()
                }
            } else if indexPath.row == 2 {
                if let checkHero = getHero {
                    cell.setStat(hero: checkHero, stat: .B_Deff)
                    return cell
                } else {
                    return UITableViewCell()
                }
            } else if indexPath.row == 3 {
                if let checkHero = getHero {
                    cell.setStat(hero: checkHero, stat: .B_Attk)
                    return cell
                } else {
                    return UITableViewCell()
                }
            } else {
                return UITableViewCell()
            }
            
        } else if indexPath.section == 4 {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "StatCell", for: indexPath) as? HeroStatTableViewCell else {
                    return UITableViewCell()
                }
                if let checkHero = getHero {
                    cell.setStat(hero: checkHero, stat: .B_Spd)
                    return cell
                } else {
                    return UITableViewCell()
                }
            } else {
                return UITableViewCell()
            }
        } else if indexPath.section == 5 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeroTypeCell", for: indexPath) as? SortTableViewCell else {
                return UITableViewCell()
            }
            
            if let value = getHero?.roles[indexPath.row] {
                cell.setValue(plain: value)
            } else {
                return UITableViewCell()
            }
            
            return cell
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
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        if section == 0 {
            return 30
        } else if section == 1 {
            return 30
        } else if section == 2 {
            return 30
        } else if section == 3 {
            return 30
        } else if section == 4 {
            return 30
        } else if section == 5 {
            return 30
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 5 {
            if getHero?.roles.count == 0 {
                return nil
            } else {
                let emptyView = UIView()
                emptyView.backgroundColor = .gray
                return emptyView
            }
        } else {
            let emptyView = UIView()
            emptyView.backgroundColor = .gray
            return emptyView
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let emptyView = UIView()
            emptyView.backgroundColor = .gray
            return emptyView
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        } else {
            return 0
        }
    }
}
