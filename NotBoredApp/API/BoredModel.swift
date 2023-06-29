//
//  BoredModel.swift
//  Projeto-integrador-2
//
//  Created by Karina Piloupas Da Costa on 08/09/22.
//

import Foundation

struct BoredModel: Codable {
    
    let activity: String
    let type: String
    let participants: Int
    
    init(_ activity: String, _ type: String, _ participants: Int) {
        self.activity = activity
        self.type = type
        self.participants = participants
    }
}
