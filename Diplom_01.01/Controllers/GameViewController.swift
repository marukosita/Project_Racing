//
//  GameViewController.swift
//  Diplom_01.01
//
//  Created by Maria on 14.02.25.
//

import UIKit

enum BarrierPosition: CaseIterable {
    case left
    case right
}
enum gameStatus {
    case start
    case stop
}

class GameViewController: UIViewController {
    
    private let roadView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Cnst.GameVC.ImageName.roadView)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let firstLeftRoadSideView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Cnst.GameVC.ImageName.leftRoadSide)
        view.contentMode = .scaleToFill
        return view
    }()
    private let secondLeftRoadSideView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Cnst.GameVC.ImageName.leftRoadSide)
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let firstRightRoadSideView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Cnst.GameVC.ImageName.rightRoadSide)
        view.contentMode = .scaleToFill
        return view
    }()
    private let secondRightRoadSideView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Cnst.GameVC.ImageName.rightRoadSide)
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let firstSeparationLineView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Cnst.GameVC.ImageName.separationLine)
        view.contentMode = .scaleToFill
        return view
    }()
    private let secondSeparationLineView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Cnst.GameVC.ImageName.separationLine)
        view.contentMode = .scaleToFill
        return view
    }()
    
    private let carView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: PickerManager.shared.carImageArray[PickerManager.shared.gameSettings.carView].gameCarImage)
        view.contentMode = .scaleToFill
        return view
    }()
    private let leftBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(Cnst.GameVC.Text.leftBtnTitle, for: .normal)
        btn.setImage(UIImage(named: Cnst.GameVC.ImageName.leftBtn), for: .normal)
        btn.layer.cornerRadius = Cnst.mainCornerRadius
        return btn
    }()
    private let rightBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(Cnst.GameVC.Text.rightBtnTitle, for: .normal)
        btn.setImage(UIImage(named: Cnst.GameVC.ImageName.rightBtn), for: .normal)
        btn.layer.cornerRadius = Cnst.mainCornerRadius
        return btn
    }()
    
    // view проигрыша
    private let losingGameView: UIView = {
        let view = UIView()
        view.backgroundColor = Cnst.mainBackgroundColor
        view.layer.cornerRadius = Cnst.mainCornerRadius
        return view
    }()
    private let losingGameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 6
        lbl.font = Cnst.GameVC.LosingGameView.font
        lbl.textColor = Cnst.mainTextColor
        
        return lbl
    }()
    
    private let backToStartViewBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(Cnst.GameVC.Text.backToStartViewBtnTitle, for: .normal)
        btn.layer.borderWidth = Cnst.GameVC.LosingGameView.btnBorderWidth
        btn.layer.borderColor = Cnst.GameVC.LosingGameView.btnBorderColor
        btn.layer.cornerRadius = Cnst.mainCornerRadius
        btn.titleLabel?.font = Cnst.GameVC.LosingGameView.font
        return btn
    }()
    
    let carCrashView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: Cnst.GameVC.ImageName.carCrash)
        view.clipsToBounds = true
        view.layer.cornerRadius = Cnst.mainCornerRadius
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    var raceStartTimeForRecords: String = "00.00.00 00:00"
    var passedBarriers: Int = 0
    var arrayOfBarriers: [UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        startNewGame()
    }
    
    // MARK: ConfigureUI
    private func configureUI() {
        view.addSubview(roadView)
        view.addSubview(firstLeftRoadSideView)
        view.addSubview(secondLeftRoadSideView)
        view.addSubview(firstRightRoadSideView)
        view.addSubview(secondRightRoadSideView)
        view.addSubview(firstSeparationLineView)
        view.addSubview(secondSeparationLineView)
        view.addSubview(carView)
        view.addSubview(leftBtn)
        view.addSubview(rightBtn)
        
        
        roadView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(view.frame.size.width * Cnst.GameVC.UI.roadViewPctScreen)
            make.height.equalTo(view.frame.size.height)
        }
        
        leftBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.height.width.equalTo(70)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        let leftBtnAction = UIAction { _ in
            self.clickLeftBtn()
            print("left click")
        }
        leftBtn.addAction(leftBtnAction, for: .touchUpInside)
        
        rightBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(70)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        let rightBtnAction = UIAction { _ in
            self.clickRightBtn()
            print("right click")
        }
        rightBtn.addAction(rightBtnAction, for: .touchUpInside)
    }
    
    // MARK: Configure animated UI
    private func configureAnimatedUI() {
        firstLeftRoadSideView.frame = CGRect(
            x: view.frame.minX,
            y: view.frame.minY,
            width: view.frame.size.width * Cnst.GameVC.UI.roadSidePctScreen,
            height: view.frame.size.height
        )
        secondLeftRoadSideView.frame = CGRect(
            x: view.frame.minX,
            y: view.frame.minY - view.frame.size.height,
            width: view.frame.size.width * Cnst.GameVC.UI.roadSidePctScreen,
            height: view.frame.size.height
        )
        
        firstRightRoadSideView.frame = CGRect(
            x: view.frame.maxX - view.frame.size.width * Cnst.GameVC.UI.roadSidePctScreen,
            y: view.frame.minY,
            width: view.frame.size.width * Cnst.GameVC.UI.roadSidePctScreen,
            height: view.frame.size.height
        )
        secondRightRoadSideView.frame = CGRect(
            x: view.frame.maxX - view.frame.size.width * Cnst.GameVC.UI.roadSidePctScreen,
            y: view.frame.minY - view.frame.size.height,
            width: view.frame.size.width * Cnst.GameVC.UI.roadSidePctScreen,
            height: view.frame.size.height
        )
        firstSeparationLineView.frame = CGRect(
            x: view.frame.midX - view.frame.size.width * Cnst.GameVC.UI.separationLinePctScreen / 2,
            y: view.frame.minY,
            width: view.frame.size.width * Cnst.GameVC.UI.separationLinePctScreen,
            height: view.frame.size.height
        )
        secondSeparationLineView.frame = CGRect(
            x: view.frame.midX - view.frame.size.width * Cnst.GameVC.UI.separationLinePctScreen / 2,
            y: view.frame.minY - view.frame.size.height,
            width: view.frame.size.width * Cnst.GameVC.UI.separationLinePctScreen,
            height: view.frame.size.height
        )
        carView.frame = CGRect(
            x: firstSeparationLineView.frame.maxX,
            y: view.frame.maxY - view.frame.width * Cnst.GameVC.UI.carViewHeightPctScreen - view.frame.height * Cnst.GameVC.UI.carViewBottomToViewBottomPctScreen,
            width: view.frame.width * Cnst.GameVC.UI.carViewWidthPctScreen,
            height: view.frame.width * Cnst.GameVC.UI.carViewHeightPctScreen
        )
    }
    
    // MARK: Configure lose game UI
    private func configureLoseGameUI() {
        view.addSubview(losingGameView)
        losingGameView.addSubview(losingGameLabel)
        losingGameView.addSubview(backToStartViewBtn)
        
        losingGameView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.width.equalTo(view.frame.size.width * Cnst.GameVC.LosingGameView.viewPctScreen)
        }
        losingGameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Cnst.GameVC.LosingGameView.margin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(Cnst.GameVC.LosingGameView.labelPctView)
        }
        
        losingGameLabel.text = Cnst.GameVC.Text.losingGameText + " " + "\(passedBarriers)"
        
        backToStartViewBtn.snp.makeConstraints { make in
            make.top.equalTo(losingGameLabel.snp.bottom).offset(Cnst.GameVC.LosingGameView.margin)
            make.bottom.equalToSuperview().offset(-Cnst.GameVC.LosingGameView.margin)
            make.left.equalToSuperview().offset(Cnst.GameVC.LosingGameView.margin)
            make.right.equalToSuperview().offset(-Cnst.GameVC.LosingGameView.margin)
            make.height.equalTo(Cnst.GameVC.LosingGameView.btnHeight)
        }
        let backToStartViewBtnAction = UIAction { _ in
            self.navigationController?.popViewController(animated: true)
            print("вернулись главное в меню")
        }
        backToStartViewBtn.addAction(backToStartViewBtnAction, for: .touchUpInside)
    }
    
    // MARK: - ButtonTapped
    private func clickRightBtn() {
        let newCarPoint = self.carView.frame.origin.x + carView.frame.width + firstSeparationLineView.frame.width
        if newCarPoint > roadView.frame.maxX - (carView.frame.width / 2) {
            stopGame()
        } else {
            UIView.animate(withDuration: Cnst.GameVC.Duration.animateDurationOfRightLeftBtns) {
                self.carView.frame.origin.x = newCarPoint
            }
        }
    }
    
    private func clickLeftBtn() {
        let newCarPoint = self.carView.frame.origin.x - carView.frame.width - firstSeparationLineView.frame.width
        if  newCarPoint < roadView.frame.minX - (carView.frame.width / 2)  {
            stopGame()
        } else {
            UIView.animate(withDuration: Cnst.GameVC.Duration.animateDurationOfRightLeftBtns) {
                self.carView.frame.origin.x = newCarPoint
            }
        }
    }
    
    // MARK: - get date
    private func getDateOfRace() -> String {
        dateFormatter.dateFormat = Cnst.GameVC.dateFormat
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
    
    // MARK: - animation looped items
    private func animateLoopedLines(firstLine: UIView, secondLine: UIView) {
        UIView.animate(withDuration: PickerManager.shared.gameDifficultyArray[PickerManager.shared.gameSettings.gameDifficulty].playingSpeed, delay: 0, options: .curveLinear) {
            firstLine.frame.origin.y = self.view.frame.maxY
            secondLine.frame.origin.y = self.view.frame.maxY - self.view.frame.size.height
        } completion: { _ in
            firstLine.frame.origin.y = self.view.frame.minY - self.view.frame.size.height
            if (Cnst.GameVC.gameStatusIndicator == .start) {
                self.animateLoopedLines(firstLine: secondLine, secondLine: firstLine)
            }
        }
    }
    
    private func startAnimateLoopedItems() {
        animateLoopedLines(firstLine: firstSeparationLineView, secondLine: secondSeparationLineView)
        animateLoopedLines(firstLine: firstLeftRoadSideView, secondLine: secondLeftRoadSideView)
        animateLoopedLines(firstLine: firstRightRoadSideView, secondLine: secondRightRoadSideView)
    }
    private func stopAnimateLoopedItems() {
        firstSeparationLineView.layer.removeAllAnimations()
        secondSeparationLineView.layer.removeAllAnimations()
        firstLeftRoadSideView.layer.removeAllAnimations()
        secondLeftRoadSideView.layer.removeAllAnimations()
        firstRightRoadSideView.layer.removeAllAnimations()
        secondRightRoadSideView.layer.removeAllAnimations()
    }
    
    // MARK: - checking incerts
    private func checkIncerts() {
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            print("Таймер активен")
            if Cnst.GameVC.gameStatusIndicator == .stop {
                timer.invalidate()
                if self.arrayOfBarriers.count != 0 {
                    for item in self.arrayOfBarriers {
                        item.layer.removeAllAnimations()
                    }
                }
            } else if self.arrayOfBarriers.count != 0 && Cnst.GameVC.gameStatusIndicator != .stop {
                for item in self.arrayOfBarriers {
                    if self.carView.layer.presentation()?.frame.intersects(item.layer.presentation()!.frame) == true {
                        print("Пересечение найдено!")
                        item.layer.removeAllAnimations()
                        timer.invalidate()
                        self.configureCarCrashUI()
                        self.stopGame()
                    }
                    if Cnst.GameVC.gameStatusIndicator == .stop {
                        item.layer.removeAllAnimations()
                    }
                }
            }
        }
    }
    
    
    // MARK: - Generating Barriers
    private func startGenerateBarriers() {
        checkIncerts()
        Timer.scheduledTimer(withTimeInterval: PickerManager.shared.gameDifficultyArray[PickerManager.shared.gameSettings.gameDifficulty].barrierGenerationSpeed, repeats: true) { timer in
            if Cnst.GameVC.gameStatusIndicator == gameStatus.start {
                self.createBarrierAnimation()
            } else {
                timer.invalidate()
            }
        }
    }
    
    private func createBarrierAnimation() {
        let positionGenerator = BarrierPosition.allCases.randomElement()
        let barrier: UIImageView = configureBarrier(for: positionGenerator!)
        
        UIView.animate(withDuration: PickerManager.shared.gameDifficultyArray[PickerManager.shared.gameSettings.gameDifficulty].playingSpeed, delay: 0, options: .curveLinear) {
            barrier.frame.origin.y = self.view.frame.maxY
        }  completion: { _ in
            if Cnst.GameVC.gameStatusIndicator == .start {
                self.passedBarriers += 1
                self.arrayOfBarriers.removeFirst()
                barrier.removeFromSuperview()
            }
        }
    }
    
    private func configureBarrier(for side: BarrierPosition) -> UIImageView {
        let barrier: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(named: PickerManager.shared.typeOfBarriersArray[PickerManager.shared.gameSettings.typeOfBarriers])
            view.layer.cornerRadius = Cnst.mainCornerRadius
            view.clipsToBounds = true
            return view
        }()
        view.addSubview(barrier)
        arrayOfBarriers.append(barrier)
        
        switch side {
        case .right:
            barrier.frame = CGRect(
                x: firstSeparationLineView.frame.maxX + (view.frame.width * Cnst.GameVC.UI.separationLinePctScreen),
                y: view.frame.minY - view.frame.width * Cnst.GameVC.UI.barrierViewPctScreen,
                width: view.frame.width * Cnst.GameVC.UI.barrierViewPctScreen,
                height: view.frame.width * Cnst.GameVC.UI.barrierViewPctScreen
            )
        case .left:
            barrier.frame = CGRect(
                x: firstSeparationLineView.frame.minX - (view.frame.width * Cnst.GameVC.UI.separationLinePctScreen) - (view.frame.width * Cnst.GameVC.UI.barrierViewPctScreen),
                y: view.frame.minY - view.frame.width * Cnst.GameVC.UI.barrierViewPctScreen,
                width: view.frame.width * Cnst.GameVC.UI.barrierViewPctScreen,
                height: view.frame.width * Cnst.GameVC.UI.barrierViewPctScreen
            )
        }
        return barrier
    }
    
    // MARK: - stop game configuration
    private func configureCarCrashUI() {
        view.addSubview(carCrashView)
        carCrashView.frame = CGRect(
            x: carView.frame.minX,
            y: carView.frame.minY - view.frame.width * 0.3 / 2,
            width: view.frame.width * 0.3,
            height: view.frame.width * 0.3
        )
    }
    
    private func stopGame() {
        print("Game over")
        Cnst.GameVC.gameStatusIndicator = .stop
        
        leftBtn.isEnabled = false
        rightBtn.isEnabled = false
        
        configureLoseGameUI()
        
        stopAnimateLoopedItems()
        
        collectDataForRecords()
        raceStartTimeForRecords = "00.00.00 00:00"
    }
    
    // MARK: - strat game configuration
    private func startNewGame() {
        carCrashView.removeFromSuperview()
        arrayOfBarriers = []
        Cnst.GameVC.gameStatusIndicator = .start
        configureAnimatedUI()
        startAnimateLoopedItems()
        startGenerateBarriers()
        passedBarriers = 0
        leftBtn.isEnabled = true
        rightBtn.isEnabled = true
        raceStartTimeForRecords = getDateOfRace()
    }
    
    // MARK: - save data for records
    private func collectDataForRecords() {
        let recordData = GameRecords(
            gameSettings: PickerManager.shared.gameSettings,
            numberOfBarriers: passedBarriers,
            raceStartTime: raceStartTimeForRecords
        )
        
        // получаем данные о прошлых заездах, если они были
        guard var records = RecordsStorageManager.shared.load() else {
            RecordsStorageManager.shared.save(gameRecords: [recordData])
            return
        }
        records.append(recordData)
        
        // сортируем данные
        var sortedRecords = records.sorted { $0.numberOfBarriers > $1.numberOfBarriers }
        
        if sortedRecords.count > 20 {
            sortedRecords.removeLast()
            }
        RecordsStorageManager.shared.save(gameRecords: sortedRecords)
    }
}
