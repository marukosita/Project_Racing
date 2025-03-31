//
//  GameSettings.swift
//  Diplom_01.01
//
//  Created by Maria on 17.02.25.
//

import Foundation


final class GameSettings: Codable {
    var userPhoto: Data?
    var userName: String
    var carView: Int
    var typeOfBarriers: Int
    var gameDifficulty: Int
    
    init(userPhoto: Data?, userName: String, carView: Int, typeOfBarriers: Int, gameDifficulty: Int) {
        self.userPhoto = userPhoto
        self.userName = userName
        self.carView = carView
        self.typeOfBarriers = typeOfBarriers
        self.gameDifficulty = gameDifficulty
    }
}
