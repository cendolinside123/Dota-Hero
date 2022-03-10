//
//  ListHeroStatVMGuideline.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

protocol ListHeroStatVMGuideline {
    var heroFilter: (([Hero]) -> Void)? { get set }
    var heroResult: (([Hero]) -> Void)? { get set }
    var fetchError: ((Error) -> Void)? { get set }
    var sortHero: (([Hero]) -> Void)? { get set }
    var getFavorite: ((Int) -> Void)? { get set }
    var result: [Hero] { get set }
    func loadHero(retry time: Int)
    func filterHero(role: HeroRole)
    func sortHero(by base: Sort)
    func setFavorite(hero select: Hero, is favorite: Bool)
}

struct ListHeroUseCase {
    let heroDataSource: HeroStatNetworkProvider
    let favoriteDataSource: FavoriteDataProvider
}
