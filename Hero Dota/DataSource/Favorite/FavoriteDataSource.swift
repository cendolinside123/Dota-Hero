//
//  FavoriteDataSource.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation
import CoreData

struct FavoriteDataSource {
    private let cdStack: CoreDataStack
    
    init(cdStack: CoreDataStack) {
        self.cdStack = cdStack
    }
    
}
extension FavoriteDataSource: FavoriteDataProvider {
    func addHero(hero input: Hero, completion: @escaping (NetworkResult<Int>) -> Void) {
        self.cdStack.doInBackground(managedContext: { context in
            do {
                let aFavorite = Favorite(context: context)
                aFavorite.heroID = Int16(input.id)
                try context.save()
                completion(.success(input.id))
            } catch let error as NSError {
                completion(.failed(error))
            }
        })
    }
    
    func getaHero(hero input: Hero, completion: @escaping (NetworkResult<Int>) -> Void) {
        let fetchFavorite: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchFavorite.predicate = NSPredicate(format: "%K == \(input.id)", (\Favorite.heroID)._kvcKeyPathString!)
        self.cdStack.doInBackground(managedContext: { context in
            do {
                let getAllHero = try context.fetch(fetchFavorite)
                
                if let getOneHero = getAllHero.first {
                    completion(.success(Int(getOneHero.heroID)))
                } else {
                    completion(.failed(ErrorResponse.emptyData))
                }
                
            } catch let error as NSError {
                completion(.failed(error))
            }
        })
    }
    
    func getAllHero(completion: @escaping (NetworkResult<[Int]>) -> Void) {
        self.cdStack.doInBackground(managedContext: { context in
            let fetchFavorite: NSFetchRequest<Favorite> = Favorite.fetchRequest()
            do {
                let getAllHero = try context.fetch(fetchFavorite)
                
                var listID: [Int] = []
                
                for getHero in getAllHero {
                    listID.append(Int(getHero.heroID))
                }
                completion(.success(listID))
            } catch let error as NSError {
                completion(.failed(error))
            }
        })
    }
    
    func deleteaHero(hero input: Hero, completion: @escaping (NetworkResult<Int>) -> Void) {
        let fetchFavorite: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchFavorite.predicate = NSPredicate(format: "%K == \(input.id)", (\Favorite.heroID)._kvcKeyPathString!)
        self.cdStack.doInBackground(managedContext: { context in
            do {
                if let getaFavorite = try context.fetch(fetchFavorite).first {
                    context.delete(getaFavorite)
                    try context.save()
                    completion(.success(input.id))
                } else {
                    completion(.failed(ErrorResponse.emptyData))
                }
            } catch let error as NSError {
                completion(.failed(error))
            }
        })
    }
}
