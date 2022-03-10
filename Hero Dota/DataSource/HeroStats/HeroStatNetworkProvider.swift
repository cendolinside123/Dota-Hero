//
//  HeroStatNetworkProvider.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

protocol HeroStatNetworkProvider {
    func getHero(completion: @escaping (NetworkResult<[Hero]>) -> Void)
}
