//
//  OpponentsModel.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 12/04/23.
//

import Foundation
enum OpponentsCases : Int, CaseIterable, Identifiable {
    case obs1
    case obs2
    case obs3
    case obs4
    
    var id : Int { return rawValue}
    
    var imageName : String {
        switch self {
            
        case .obs1:
            return "opponents"
        case .obs2:
            return "opponents-1"
        case .obs3:
            return "opponents-2"
        case .obs4:
            return "opponents-3"
        }
    }
}
