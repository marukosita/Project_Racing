//
//  StorageManager.swift
//  Diplom_01.01
//
//  Created by Maria on 17.02.25.
//

import Foundation
private extension String {
    static let gameSettings = "gameSettings"
    static let gameRecords = "gameRecords"
}

final class StorageManager {
    
    static let shared = StorageManager()
    private init() { }
    
    func save(gameSettings: GameSettings) {
        UserDefaults.standard.set(encodable: gameSettings, forKey: .gameSettings)
    }
    func load() -> GameSettings? {
        let gameSettings = UserDefaults.standard.value(GameSettings.self, forKey: .gameSettings)
        return gameSettings
    }
}


final class RecordsStorageManager {
    static let shared = RecordsStorageManager()
    private init() {}
    
    func save(gameRecords: [GameRecords]) {
        UserDefaults.standard.set(encodable: gameRecords, forKey: .gameRecords)
    }
    func load() -> [GameRecords]? {
        let gameRecords = UserDefaults.standard.value(Array<GameRecords>.self, forKey: .gameRecords)
        return gameRecords
    }
}
