//
//  ListHeroStatViewModel.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

class ListHeroStatViewModel {
    var heroFilter: (([Hero]) -> Void)?
    var heroResult: (([Hero]) -> Void)?
    var fetchError: ((Error) -> Void)?
    var sortHero: (([Hero]) -> Void)?
    var getFavorite: ((Int) -> Void)?
    var result: [Hero] = []
    
    private var useCase: ListHeroUseCase
    private var originalData: [Hero] = []
    private var currenFilter: HeroRole = .All
    private var currentSort: Sort = .None
    
    init(useCase: ListHeroUseCase) {
        self.useCase = useCase
    }
    
}

extension ListHeroStatViewModel {
    private func doSorting(data: [Hero], base: Sort) -> [Hero] {
        switch base {
        case .None:
            return originalData
        case .B_Attk:
            return data.sorted(by: { $0.base_attack_min < $1.base_attack_min })
        case .B_HP:
            return data.sorted(by: { $0.base_health < $1.base_health })
        case .B_MP:
            return data.sorted(by: { $0.base_mana < $1.base_mana })
        case .B_Spd:
            return data.sorted(by: { $0.move_speed < $1.move_speed })
        }
    }
    
    private func doFilter(data: [Hero], base: HeroRole) -> [Hero] {
//        self.result = originalData
        switch base {
        case .All:
            return originalData
        default:
            return data.filter({
                $0.roles.contains(base.rawValue)
            })
            
        }
        
    }
}

extension ListHeroStatViewModel: ListHeroStatVMGuideline {
    func sortHero(by base: Sort) {
        currentSort = base
        switch base {
        case .None:
            self.result = originalData
            self.result = doFilter(data: result, base: currenFilter)
        case .B_Attk:
            self.result = doSorting(data: self.result, base: .B_Attk)
            
        case .B_HP:
            self.result = doSorting(data: self.result, base: .B_HP)
            
        case .B_MP:
            self.result = doSorting(data: self.result, base: .B_MP)
            
        case .B_Spd:
            self.result = doSorting(data: self.result, base: .B_Spd)
            
        }
        
        self.sortHero?(result)
    }
    
    func loadHero(retry time: Int) {
        let group = DispatchGroup()
        var errorMessage: Error?
        group.enter()
        self.useCase.heroDataSource.getHero(completion: { [weak self] response in
            switch response {
            case .success(let data):
                self?.result = data
                self?.originalData = data
//                self?.heroResult?(data)
                
            case .failed(let error):
                errorMessage = error
                
            }
            group.leave()
        })
        
        group.notify(queue: .global(), execute: { [weak self] in
            guard let superSelf = self else {
                return
            }
            if time > 0 {
                if errorMessage != nil {
                    superSelf.loadHero(retry: time - 1)
                    return
                }
            } else {
                superSelf.fetchError?(errorMessage ?? ErrorResponse.loadFailed)
                return
            }
            
            superSelf.useCase.favoriteDataSource.getAllHero(completion: { response in
                switch response {
                case .success(let data):
                    if data.count > 0 {
                        for getFav in data {
                            for index in 0...superSelf.result.count - 1 {
                                if superSelf.result[index].id == getFav {
                                    superSelf.result[index].updateFavorite(is: true)
                                }
                            }
                            for index in 0...superSelf.originalData.count - 1 {
                                if superSelf.originalData[index].id == getFav {
                                    superSelf.originalData[index].updateFavorite(is: true)
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            superSelf.heroResult?(superSelf.result)
                        }
                    } else {
                        DispatchQueue.main.async {
                            superSelf.heroResult?(superSelf.result)
                        }
                    }
                    break
                case .failed(_):
                    DispatchQueue.main.async {
                        superSelf.heroResult?(superSelf.result)
                    }
                    break
                }
            })
        })
    }
    
    func filterHero(role: HeroRole) {
        currenFilter = role
//        if currentSort == .None {
//            self.result = originalData
//        }
        self.result = originalData
        self.result = doFilter(data: originalData, base: role)
        
        if currentSort != .None {
            self.result = self.doSorting(data: result, base: currentSort)
        }
        heroFilter?(result)
    }
    
    func setFavorite(hero select: Hero, is favorite: Bool) {
        if favorite {
            self.useCase.favoriteDataSource.addHero(hero: select, completion: { [weak self] response in
                guard let superSelf = self else {
                    return
                }
                switch response {
                case .success(let data):
                    var selectedIndex: Int?
                    for index in 0...superSelf.result.count - 1 {
                        if superSelf.result[index].id == data {
                            superSelf.result[index].updateFavorite(is: favorite)
                            selectedIndex = index
                        }
                    }
                    for index in 0...superSelf.originalData.count - 1 {
                        if superSelf.originalData[index].id == data {
                            superSelf.originalData[index].updateFavorite(is: favorite)
                        }
                    }
                    if let getIndex = selectedIndex {
                        DispatchQueue.main.async {
                            superSelf.getFavorite?(getIndex)
                        }
                    }
                    break
                case .failed(_):
                    break
                }
            })
        } else {
            self.useCase.favoriteDataSource.deleteaHero(hero: select, completion: { [weak self] response in
                guard let superSelf = self else {
                    return
                }
                switch response {
                case .success(let data):
                    var selectedIndex: Int?
                    for index in 0...superSelf.result.count - 1 {
                        if superSelf.result[index].id == data {
                            superSelf.result[index].updateFavorite(is: favorite)
                            selectedIndex = index
                        }
                    }
                    for index in 0...superSelf.originalData.count - 1 {
                        if superSelf.originalData[index].id == data {
                            superSelf.originalData[index].updateFavorite(is: favorite)
                        }
                    }
                    if let getIndex = selectedIndex {
                        DispatchQueue.main.async {
                            superSelf.getFavorite?(getIndex)
                        }
                    }
                    break
                case .failed(_):
                    break
                }
                
            })
        }
        
    }
    
}
