//
//  HomeViewController.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import UIKit

class HomeViewController: UIViewController {

    private let groupDispatch = DispatchGroup()
    private var coreDataStack: CoreDataStack?
    private let heroType = [HeroRole.All.rawValue, HeroRole.Disabler.rawValue, HeroRole.Carry.rawValue, HeroRole.Durable.rawValue, HeroRole.Escape.rawValue, HeroRole.Initiator.rawValue, HeroRole.Jungler.rawValue, HeroRole.Nuker.rawValue ]
    
    private let listFilter: UICollectionView = {
        
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.minimumLineSpacing = 5
        flow.minimumInteritemSpacing = 5
        flow.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flow)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let collectionView: UICollectionView = {
            
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.minimumLineSpacing = 10
        flow.minimumInteritemSpacing = 10
        flow.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flow)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let loadingSpinner = UIActivityIndicatorView()
    private let loadingView = UIView()
    
    private let bottomBar = UIView()
    private let btnSort = UIButton()
    
    private var viewModel: ListHeroStatVMGuideline?
    private var uiControll: ListUIGuideHelper?
    private var currentSort: Sort = .None
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        
        addLayouts()
        addConstraints()
        setButtonSortCorner()
        addButtonAction()
        uiControll = ListProductUIControll(controller: self)
        uiControll?.showLoading(completion: nil)
        setupCollectionView()
        groupDispatch.notify(queue: .main, execute: { [weak self] in
            guard let superSelf = self, let crData = superSelf.coreDataStack else {
                return
            }
            superSelf.viewModel = ListHeroStatViewModel(useCase: ListHeroUseCase(heroDataSource: HeroStatDataSource(), favoriteDataSource: FavoriteDataSource(cdStack: crData)))
            superSelf.bind()
            superSelf.viewModel?.loadHero(retry: 3)
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func addLayouts() {
        addListFilter()
        setLoadingView()
        addCollectionView()
        addBottomBar()
        addSortButton()
    }
    
    private func addConstraints() {
        let views: [String: Any] = ["listFilter": listFilter, "collectionView": collectionView, "loadingView": loadingView, "loadingSpinner": loadingSpinner, "bottomBar": bottomBar, "btnSort": btnSort]
        let metrix: [String: Any] = [:]
        var constraints: [NSLayoutConstraint] = []
        
        
        // MARK: listFilter, loadingView, collectionView, bottomBar constraints
        listFilter.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        let hCollectionView = "H:|-1-[collectionView]-1-|"
        let vListFilterLoadingViewCollectionViewBottomBar = "V:|-[listFilter]-0-[loadingView]-0-[collectionView]-0-[bottomBar]-|"
        let hLoadingView = "H:|-0-[loadingView]-0-|"
        let hListFilter = "H:|-0-[listFilter]-0-|"
        let hBottomBar = "H:|-0-[bottomBar]-0-|"
        
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hListFilter, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLoadingView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hCollectionView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hBottomBar, options: .alignAllTop, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: vListFilterLoadingViewCollectionViewBottomBar, options: .alignAllLeading, metrics: metrix, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: hLoadingView, options: .alignAllTop, metrics: metrix, views: views)
        constraints += [NSLayoutConstraint(item: listFilter, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)]
        constraints += [NSLayoutConstraint(item: bottomBar, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/9, constant: 0)]
        let loadingViewHeight = NSLayoutConstraint(item: loadingView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1/9, constant: 0)
        loadingViewHeight.identifier = "loadingViewHeight"
        constraints += [loadingViewHeight]
        
        // MARK: loadingSpinner constraints
        loadingSpinner.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerX, relatedBy: .equal, toItem: loadingView, attribute: .centerX, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: loadingSpinner, attribute: .centerY, relatedBy: .equal, toItem: loadingView, attribute: .centerY, multiplier: 1, constant: 0)]
        
        // MARK: btnSort constraints
        btnSort.translatesAutoresizingMaskIntoConstraints = false
        constraints += [NSLayoutConstraint(item: btnSort, attribute: .centerY, relatedBy: .equal, toItem: bottomBar, attribute: .centerY, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: btnSort, attribute: .height, relatedBy: .equal, toItem: bottomBar, attribute: .height, multiplier: 3/5, constant: 0)]
        constraints += [NSLayoutConstraint(item: btnSort, attribute: .width, relatedBy: .equal, toItem: btnSort, attribute: .height, multiplier: 1, constant: 0)]
        constraints += [NSLayoutConstraint(item: btnSort, attribute: .trailing, relatedBy: .equal, toItem: bottomBar, attribute: .trailing, multiplier: 1, constant: -20)]
        NSLayoutConstraint.activate(constraints)
        btnSort.layoutIfNeeded()
    }
    
    private func addListFilter() {
        view.addSubview(listFilter)
    }
    
    private func setLoadingView() {
        loadingSpinner.color = .gray
        loadingView.addSubview(loadingSpinner)
        loadingSpinner.startAnimating()
        loadingView.backgroundColor = .white
        view.addSubview(loadingView)
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HeroCollectionViewCell.self, forCellWithReuseIdentifier: "HeroCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(cellLongPress(longPressGR:)))
        longPressGR.minimumPressDuration = 0.5
        longPressGR.delaysTouchesBegan = true
        self.collectionView.addGestureRecognizer(longPressGR)
        
        listFilter.delegate = self
        listFilter.dataSource = self
        listFilter.register(SegmenCollectionViewCell.self, forCellWithReuseIdentifier: "SegmentCell")
        listFilter.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "default")
        listFilter.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
        
    }

    private func addBottomBar() {
        bottomBar.backgroundColor = .white
        view.addSubview(bottomBar)
    }
    
    private func addSortButton() {
        btnSort.setTitle("", for: .normal)
        btnSort.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        bottomBar.addSubview(btnSort)
    }
    
    private func setButtonSortCorner() {
        btnSort.clipsToBounds = true
        btnSort.layer.borderColor = UIColor.black.cgColor
        btnSort.layer.borderWidth = 1
        btnSort.layer.cornerRadius = btnSort.bounds.width / 2
    }
    
}

extension HomeViewController {
    private func bind() {
        viewModel?.heroResult = { [weak self] _ in
            self?.collectionView.reloadData()
            self?.uiControll?.hideLoading(completion: nil)
        }
        viewModel?.sortHero = { [weak self] _ in
            self?.collectionView.reloadData()
        }
        viewModel?.heroFilter = { [weak self] _ in
            self?.collectionView.reloadData()
        }
        viewModel?.getFavorite = { [weak self] index in
            if self?.collectionView.numberOfItems(inSection: 0) != (self?.viewModel?.result.count ?? 0) {
                self?.collectionView.reloadData()
            } else {
                self?.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
            }
        }
        
    }
    
    private func addButtonAction() {
        btnSort.addTarget(self, action: #selector(sortMenu(_:)), for: .touchDown)
    }
}

extension HomeViewController {
    @objc private func sortMenu(_ sender:AnyObject?) {
        let sortVC = SortViewController()
        sortVC.setSort(select: currentSort)
        sortVC.getSortType = { [weak self] sortType in
            self?.currentSort = sortType
            self?.viewModel?.sortHero(by: sortType)
        }
        
        let nav = UINavigationController(rootViewController: sortVC)
        nav.navigationBar.barTintColor = .white
        self.present(nav, animated: true, completion: nil)
    }
}

extension HomeViewController {
    func setupCoreDataContext(coreData: CoreDataStack) {
        groupDispatch.enter()
        self.coreDataStack = coreData
        groupDispatch.leave()
    }
    
    public func getLoadingView() -> UIView {
        return loadingView
    }
    
    public func getLoadingSpinner() -> UIActivityIndicatorView {
        return loadingSpinner
    }
    
    @objc private func cellLongPress(longPressGR: UILongPressGestureRecognizer) {
        if longPressGR.state != .ended {
            return
        }
        let point = longPressGR.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        
        if let getIndexPath = indexPath {
            if let getData = viewModel?.result[getIndexPath.row] {
                viewModel?.setFavorite(hero: getData, is: !getData.isFavorite)
                
            }
        } else {
            
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return viewModel?.result.count ?? 0
        } else if collectionView == listFilter {
            return heroType.count
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as? HeroCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
            }
            
            if let getData = viewModel?.result[indexPath.row] {
                cell.setProduct(hero: getData)
            } else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
            }
            
            return cell
        } else if collectionView == listFilter {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SegmentCell", for: indexPath) as? SegmenCollectionViewCell else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
            }
            let heroType = heroType[indexPath.row]
            cell.setValue(text: heroType)
            return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as? HeroCollectionViewCell else {
                return
            }
            cell.getImage().kf.cancelDownloadTask()
            cell.getImage().image = #imageLiteral(resourceName: "loading")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == listFilter {
            let heroType = heroType[indexPath.row]
            viewModel?.filterHero(role: HeroRole(rawValue: heroType) ?? HeroRole.All)
        } else if collectionView == self.collectionView {
            let detailVC = DetailViewController()
            if let getData = viewModel?.result[indexPath.row] {
                detailVC.setDetail(hero: getData)
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            
        }
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            let width = (collectionView.bounds.width) / 3.5
            
            return CGSize(width: Int(width), height: Int(width))
        } else if collectionView == listFilter {
            let width = (collectionView.bounds.width) / 4
            
            return CGSize(width: Int(width), height: Int(collectionView.bounds.height))
        } else {
            return CGSize(width: Int(0), height: Int(0))
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            uiControll?.scrollControll(scrollView: scrollView, completion: { [weak self] in
                self?.listFilter.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
                self?.viewModel?.loadHero(retry: 3)
                self?.currentSort = .None
            })
        }
        
    }
}

