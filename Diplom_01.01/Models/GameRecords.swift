//
//  GameRecords.swift
//  Diplom_01.01
//
//  Created by Maria on 17.02.25.
//

import Foundation

final class GameRecords: Codable {
    var gameSettings: GameSettings
    var numberOfBarriers: Int
    var raceStartTime: String
    
    init(gameSettings: GameSettings, numberOfBarriers: Int, raceStartTime: String) {
        self.gameSettings = gameSettings
        self.numberOfBarriers = numberOfBarriers
        self.raceStartTime = raceStartTime
    }
}
