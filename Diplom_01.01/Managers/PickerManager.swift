//
//  PickerManager.swift
//  Diplom_01.01
//
//  Created by Maria on 17.02.25.
//

import Foundation


final class PickerManager {
    
    static let shared = PickerManager()
    
    var gameSettings: GameSettings
    
    struct Car {
        let gameCarImage: String
        let settingsCarImage: String
    }
    let carImageArray: [Car] = [
        Car(gameCarImage: "gameBlueCar", settingsCarImage: "blueCar"),
        Car(gameCarImage: "gameGreyCar", settingsCarImage: "greyCar"),
        Car(gameCarImage: "gameRedCar", settingsCarImage: "redCar"),
        Car(gameCarImage: "gameYellowCar", settingsCarImage: "yellowCar")
    ]
    
    struct GameDifficulty {
        let gameDifficultyName: String
        let playingSpeed: Double
        let barrierGenerationSpeed: Double
    }
    let gameDifficultyArray: [GameDifficulty] = [
        GameDifficulty(gameDifficultyName: "Easy", playingSpeed: 2.0, barrierGenerationSpeed: 2.0),
        GameDifficulty(gameDifficultyName: "Medium", playingSpeed: 1.5, barrierGenerationSpeed: 1),
        GameDifficulty(gameDifficultyName: "Hard", playingSpeed: 0.8, barrierGenerationSpeed: 0.5)
    ]
    
    var userPhoto: Data? = nil
    let typeOfBarriersArray = ["barriers", "boards", "bushes", "holes", "stones"]
    
    var userName = Cnst.SettingsVC.Text.userNameTextFieldText
    
    
    private init() {
        guard let gameSettingsFromStorage: GameSettings = StorageManager.shared.load() else {
            gameSettings = GameSettings(
                userPhoto: userPhoto,
                userName: userName,
                carView: 0,
                typeOfBarriers: 0,
                gameDifficulty: 0
            )
            return
        }
        gameSettings = gameSettingsFromStorage
    }
    
    
    func chooseItemForPicker<T>(
        direction: tapDirection,
        currentValue: Int,
        relevantArray: [T]
    ) -> Int {
        guard !relevantArray.isEmpty else { return currentValue }
        
        switch direction {
        case .right:
            return (currentValue + 1) % relevantArray.count
            
        case .left:
            return (currentValue - 1 + relevantArray.count) % relevantArray.count
        }
    }
}
