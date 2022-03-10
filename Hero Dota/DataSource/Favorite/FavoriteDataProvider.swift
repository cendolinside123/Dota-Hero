//
//  FavoriteDataProvider.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

protocol FavoriteDataProvider {
    func addHero(hero input: Hero, completion: @escaping (NetworkResult<Int>) -> Void)
    func getaHero(hero input: Hero, completion: @escaping (NetworkResult<Int>) -> Void)
    func getAllHero(completion: @escaping (NetworkResult<[Int]>) -> Void)
    func deleteaHero(hero input: Hero, completion: @escaping (NetworkResult<Int>) -> Void)
}
