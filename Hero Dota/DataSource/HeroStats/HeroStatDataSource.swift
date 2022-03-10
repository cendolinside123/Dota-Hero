//
//  HeroStatDataSource.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation
import Alamofire
import SwiftyJSON

struct HeroStatDataSource {
    
}

extension HeroStatDataSource: HeroStatNetworkProvider {
    
    func getHero(completion: @escaping (NetworkResult<[Hero]>) -> Void) {
        DispatchQueue.global().async {
            AF.request(Constant.url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil, requestModifier: nil).responseData(completionHandler: { response in
                switch response.result {
                case .success(let data):
                    let getJSON = JSON(data)
                    var listHero: [Hero] = []
                    
                    for getHero in getJSON.arrayValue {
                        listHero.append(Hero(hero: getHero))
                    }
                    DispatchQueue.main.async {
                        completion(.success(listHero))
                    }
                    break
                case .failure(let error):
                    completion(.failed(error))
                    break
                }
            })
        }
    }
    
    
}
