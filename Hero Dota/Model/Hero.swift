//
//  Hero.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation
import SwiftyJSON

struct Hero {
    let id: Int
    let name: String
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let roles: [String]
    let img: String
    let icon: String
    let base_health: Double
    let base_mana: Double
    let base_armor: Double
    let base_attack_min: Int
    let base_attack_max: Int
    let move_speed: Int
    var isFavorite: Bool
}

extension Hero {
    init(hero getJSON: JSON) {
        id = getJSON["id"].intValue
        name = getJSON["name"].stringValue
        localized_name = getJSON["localized_name"].stringValue
        primary_attr = getJSON["primary_attr"].stringValue
        attack_type = getJSON["attack_type"].stringValue
        roles = getJSON["roles"].arrayValue.map({ $0.stringValue})
        img = Constant.baseUrlImage + getJSON["img"].stringValue
        icon = Constant.baseUrlImage + getJSON["icon"].stringValue
        base_health = getJSON["base_health"].doubleValue
        base_mana = getJSON["base_mana"].doubleValue
        base_armor = getJSON["base_armor"].doubleValue
        base_attack_min = getJSON["base_attack_min"].intValue
        base_attack_max = getJSON["base_attack_max"].intValue
        move_speed = getJSON["move_speed"].intValue
        isFavorite = false
    }
    
    mutating func updateFavorite(is value: Bool) {
        isFavorite = value
    }
}
