//
//  Constant.swift
//  Hero Dota
//
//  Created by Jan Sebastian on 10/03/22.
//

import Foundation

struct Constant {
    static let url = "https://api.opendota.com/api/herostats"
    static let baseUrlImage = "https://steamcdn-a.akamaihd.net/"
}

enum HeroRole: String {
    case All = "All"
    case Carry = "Carry"
    case Nuker = "Nuker"
    case Initiator = "Initiator"
    case Disabler = "Disabler"
    case Durable = "Durable"
    case Escape = "Escape"
    case Support = "Support"
    case Pusher = "Pusher"
    case Jungler = "Jungler"
    
}

enum Sort: String {
    case None = "-"
    case B_Attk = "Base Attack (Lower Limit)"
    case B_HP = "Base Health"
    case B_MP = "Base Mana"
    case B_Spd = "Base Speed"
}
