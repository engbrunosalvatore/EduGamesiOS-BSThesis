//
//  RexyStateModel.swift
//  AppTesi1
//
//  Created by Salvatore Bruno on 12/04/23.
//

import Foundation

enum RexyCases : Int, CaseIterable, Identifiable {
    
    case idle
    case walk
    case gameOver
    case jump
    
    var id : Int { return rawValue}
    
    var imageName : String {
        switch self {
            
        case .idle:
            return "rexyBase"
        case .walk:
            return "rexy"
        case .gameOver:
            return "rexyFail"
        case .jump:
            return "rexyBase"
        }
    }
}
