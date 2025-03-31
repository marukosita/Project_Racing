//
//  Cnst.swift
//  Diplom_01.01
//
//  Created by Maria on 14.02.25.
//

import Foundation
import UIKit

enum Fonts: String {
    case beautyFlower = "Beauty Flower"
}

final class Cnst {
    static let mainCornerRadius: CGFloat = 20
    static let mainBackgroundColor = UIColor(hex: "#628100")
    static let mainTextColor: UIColor = .white
    
    enum backBtn {
        static let backBtnTitle = "< BACK"
        static let backBtnFont = UIFont(name: Fonts.beautyFlower.rawValue, size: 35) ?? .boldSystemFont(ofSize: 35)
        static let backBtnHeight: CGFloat = 35
        static let backBtnPctScreen = 0.20
    }
    
    
    enum MainVC {
        enum Font {
            static let mainFont: UIFont = UIFont(name: Fonts.beautyFlower.rawValue, size: 60) ?? .boldSystemFont(ofSize: 60)
        }
        enum ImageName {
            static let mainBackground = "mainBackground"
        }
        enum BtnTitle {
            static let startBtn = "START"
            static let recordsBtn = "RECORDS"
            static let settingsBtn = "SETTINGS"
        }
        enum Color {
            static let mainBtnColor: UIColor = .gray
            static let mainBtnTappedColor: UIColor = .lightGray
        }
        
        enum UI {
            static let mainBtnPctScreen: CGFloat = 0.6
            static let mainBtnHeight: CGFloat = 70
            static let mainBtnVerticalSpacing: CGFloat = 35
        }
    }
    
    
    enum SettingsVC {
        
        static let textFieldMaxLength: Int = 10
        
        enum Font {
            static let settingsFont: UIFont = UIFont(name: Fonts.beautyFlower.rawValue, size: 40) ?? .boldSystemFont(ofSize: 40)
        }
        enum Color {
            static let userNameTextFieldBackgroundColor: UIColor = .white
            static let userNameTextFieldTextColor: UIColor = .lightGray
            static let tappedColor: UIColor = .gray
        }
        
        enum Text {
            static let userNameLblText = "player name"
            static let userNameTextFieldText = "User"
            static let chooseItemViewLblText = "car view"
            static let typeOfBarriersLblText = "type of barriers"
            static let gameDifficultyLblText = "game difficulty"
        }
        enum Images {
            static let selectNewUserPhotoBtn = "plusBtn"
            static let userPhotoViewImage = "userPhoto"
            static let carViewImage = "orangeCar"
            static let settingsRightBtnImage = "rightArrowSettings"
            static let settingsLeftBtnImage = "leftArrowSettings"
            static let typeOfBarriersViewImage = "barrier"
            static let gameDifficultyViewImage = "Easy"
        }
        
        enum UI {
            static let pickerLblPctScreen: Double = 0.85
            static let userNameTextFieldPctScreen: Double = 0.6
            static let imagePickerWidthPctScreen: Double = 0.35
            static let userPhotoViewSizePctScreen: Double = 0.3
            static let selectNewUserPhotoBtnWidthPctScreen: Double = 0.04
            
            
            static let smallHorizontalSpacing: CGFloat = 5
            static let pickerLblHeight: CGFloat = 35
            static let pickerHeight: CGFloat = 45
            static let smallVerticalSpacing: CGFloat = 10
            static let mediumVerticalSpacing: CGFloat = 30
        }
    }
    
    enum GameVC {
        static var gameStatusIndicator: gameStatus = .stop
        static let dateFormat = "dd.MM.yy HH:mm"
        
        enum ImageName {
            static let roadView = "road"
            static let leftRoadSide = "leftCurb"
            static let rightRoadSide = "rightCurb"
            static let separationLine =
            "separationLine"
            static let car = "gameBlueCar"
            static let leftBtn = "leftArrow"
            static let rightBtn = "rightArrow"
            static let barrier = "bushes"
            static let carCrash = "carCrash"
        }
        
        enum Text {
            static let losingGameText = """
            you lose!
            score:
            """
            static let backToStartViewBtnTitle = "BACK"
            static let leftBtnTitle = "<--"
            static let rightBtnTitle = "-->"
        }
        
        enum LosingGameView {
            static let viewPctScreen: CGFloat = 0.8
            static let labelPctView: CGFloat = 0.9
            static let margin: CGFloat = 10
            static let btnHeight: CGFloat = 50
            static let font: UIFont = UIFont(name: Fonts.beautyFlower.rawValue, size: 45) ?? .boldSystemFont(ofSize: 45)
            static let btnBorderWidth: CGFloat = 2.0
            static let btnBorderColor = UIColor.white.cgColor
        }
        enum UI {
            static let roadViewPctScreen: CGFloat = 0.6
            static let roadSidePctScreen: CGFloat = 0.2
            static let separationLinePctScreen: CGFloat = 0.02
            static let carViewWidthPctScreen: CGFloat = 0.25
            static let carViewHeightPctScreen: CGFloat = 0.4
            static let carViewBottomToViewBottomPctScreen: CGFloat = 0.07
            static let barrierViewPctScreen: CGFloat = 0.20
        }
        
        enum Duration {
            static let speedOfAnimation: Double = 0.8
            static let speedOfGenerationBarriers: Double = 0.5
            static let animateDurationOfRightLeftBtns: Double = 0.1
        }
    }
    
    enum RecordsVC {
        static let recordsFont: UIFont = UIFont(name: Fonts.beautyFlower.rawValue, size: 30) ?? .boldSystemFont(ofSize: 30)
        static let recordsFontRaceStartTimeLabel: UIFont = UIFont(name: Fonts.beautyFlower.rawValue, size: 25) ?? .boldSystemFont(ofSize: 25)
        
        
       
        static let smallSpacing: CGFloat = 0.01
        static let placeInTableLabelWidth:CGFloat = 0.08
        static let userPhotoHeightWidth: CGFloat = 0.14
        static let userNameLblWidth: CGFloat = 0.21
        static let numberOfBarriersLblWidth: CGFloat = 0.1
        static let gameDifficultyLblWidth: CGFloat = 0.2
        static let raceStartTimeLblWidth: CGFloat = 0.2
    }
}
