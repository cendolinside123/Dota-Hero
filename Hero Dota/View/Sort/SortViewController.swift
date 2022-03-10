//
//  SortViewController.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 11/03/22.
//

import UIKit

class SortViewController: UIViewController {

    private let tblMenu: UITableView = {
        let tabel = UITableView()
        tabel.backgroundColor = .white
        tabel.allowsSelection = true
        return tabel
    }()
    private let listSortMenu: [Sort] = [Sort.B_Attk, Sort.B_HP, Sort.B_MP, Sort.B_Spd]
    var getSortType: ((Sort) -> Void)?
    private var selectedSort: Sort?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Sort Heroes"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneSelect(sender: )))
        self.view.backgroundColor = .white
        addLayout()
        addConstraints()
        setupTabel()
        setSelected()
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
        let views: [String: Any] = ["tblMenu": tblMenu]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        // MARK: tblMenu constraints
        tblMenu.translatesAutoresizingMaskIntoConstraints = false
        let hTblMenu = "H:|-[tblMenu]-|"
        let vTblMenu = "V:|-0-[tblMenu]-0-|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hTblMenu, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vTblMenu, options: .alignAllLeading, metrics: metrix, views: views)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func addTabel() {
        view.addSubview(tblMenu)
    }
    
    private func setupTabel() {
        tblMenu.delegate = self
        tblMenu.dataSource = self
        tblMenu.register(SortTableViewCell.self, forCellReuseIdentifier: "SortCell")
    }

    private func setSelected() {
        if let getSort = selectedSort, getSort != .None {
            if let getIndex = listSortMenu.firstIndex(where: { $0 == getSort}), getIndex < listSortMenu.count {
                tblMenu.selectRow(at: IndexPath(row: getIndex, section: 0), animated: true, scrollPosition: .none)
            }
        }
    }
    
}
extension SortViewController {
    @objc private func doneSelect(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: { [weak self] in
            self?.getSortType?(self?.selectedSort ?? .None)
        })
    }
}

extension SortViewController {
    func setSort(select sort: Sort) {
        if sort != .None {
            selectedSort = sort
        }
    }
}

extension SortViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listSortMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SortCell", for: indexPath) as? SortTableViewCell else {
            return UITableViewCell()
        }
        let value = listSortMenu[indexPath.row]
        cell.setValue(text: value)
        cell.selectionStyle = .default
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedSort != listSortMenu[indexPath.row] {
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            selectedSort = listSortMenu[indexPath.row]
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
            selectedSort = .None
        }
    }
}
